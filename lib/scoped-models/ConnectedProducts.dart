import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;

  void addProduct({String title, String desc, String image, double price}) {
    Product pr = Product(
        title: title,
        image: image,
        description: desc,
        price: price,
        userId: _authenticatedUser.id,
        userEmail: _authenticatedUser.email);
    _products.add(pr);
    _selProductIndex = null;
    notifyListeners();
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

  void updateProduct({String title, String desc, String image, double price}) {
    Product pr = Product(
        title: title,
        image: image,
        description: desc,
        price: price,
        userId: getSelectedProduct().userId,
        userEmail: getSelectedProduct().userEmail);

    _products[_selProductIndex] = pr;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selProductIndex);
    notifyListeners();
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
}
