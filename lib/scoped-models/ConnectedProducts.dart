import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;
  bool _isLoading = false;

  Future<Null> addProduct(
      {String title, String desc, String image, double price}) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': desc,
      'image':
          'https://localtvkdvr.files.wordpress.com/2019/01/gettyimages-932817986-e1547580064551.jpg?quality=85&strip=all&w=400&h=225&crop=1',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http
        .post('https://udemyapp-ece26.firebaseio.com/products.json',
            body: json.encode(productData))
        .then(
      (http.Response resp) {
        final Map<String, dynamic> responseData = json.decode(resp.body);
        Product pr = Product(
            id: responseData['name'],
            title: title,
            image: image,
            description: desc,
            price: price,
            userId: _authenticatedUser.id,
            userEmail: _authenticatedUser.email);
        _products.add(pr);
        _selProductIndex = null;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: "asdasd", email: email, password: password);
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  Future<Null> updateProduct(
      {String title, String desc, String image, double price}) {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updatedData = {
      'title': title,
      'description': desc,
      'image': getSelectedProduct().image,
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    return http
        .put(
            'https://udemyapp-ece26.firebaseio.com/products/${getSelectedProduct().id}.json',
            body: json.encode(updatedData))
        .then((http.Response resp) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _isLoading = true;

    final String id = getSelectedProduct().id;

    _products.removeAt(_selProductIndex);

    notifyListeners();

    http
        .delete('https://udemyapp-ece26.firebaseio.com/products/$id.json')
        .then((http.Response resp) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void setSelectedProductIndex(int value) {
    _selProductIndex = value;
    if (_selProductIndex != null) {
      notifyListeners();
    }
  }

  int getSelectedProductIndex() {
    return _selProductIndex;
  }

  Product getSelectedProduct() {
    return _selProductIndex != null ? allProducts[_selProductIndex] : null;
  }

  void toggleFavorites() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  bool get displayFavorites {
    return _showFavorites;
  }

  void toggleProductFavorite() {
    Product currProduct = getSelectedProduct();
    final Product newProduct = Product(
        title: currProduct.title,
        image: currProduct.image,
        description: currProduct.description,
        price: currProduct.price,
        isFavorite: !currProduct.isFavorite,
        userId: currProduct.userId,
        userEmail: currProduct.userEmail);
    _products[_selProductIndex] = newProduct;
    notifyListeners();
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http.get('https://udemyapp-ece26.firebaseio.com/products.json').then(
      (http.Response resp) {
        final Map<String, dynamic> productListData = json.decode(resp.body);

        if (productListData == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }

        List<Product> fetchedList = [];

        productListData.forEach((String productId, dynamic productData) {
          Product pr = Product(
              id: productId,
              title: productData['title'],
              image: productData['image'],
              description: productData['description'],
              price: productData['price'],
              userId: productData['userId'],
              userEmail: productData['userEmail']);
          fetchedList.add(pr);
        });
        _products = fetchedList;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
