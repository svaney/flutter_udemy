import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/scoped-models/ConnectedProducts.dart';

mixin ProductsModel on ConnectedProducts {


  bool _showFavorites = false;


  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites){
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  void updateProduct(Product product) {
    products[selProductIndex] = product;
    setSelectedProductIndex(null);
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selProductIndex);
    setSelectedProductIndex(null);
    notifyListeners();
  }

  void setSelectedProductIndex(int value) {
    selProductIndex = value;
    notifyListeners();
  }

  int getSelectedProductIndex() {
    return selProductIndex;
  }

  Product getSelectedProduct() {
    return selProductIndex != null
        ? allProducts[selProductIndex]
        : null;
  }

  void toggleFavorites(){
    _showFavorites = ! _showFavorites;
    notifyListeners();
    selProductIndex = null;
  }

  bool get displayFavorites {
    return _showFavorites;
  }

  void toggleProductFavorite() {
    Product currProduct = products[selProductIndex];
    final Product newProduct = Product(
        title: currProduct.title,
        image: currProduct.image,
        description: currProduct.description,
        price: currProduct.price,
        isFavorite: !currProduct.isFavorite);
    products[selProductIndex] = newProduct;
    selProductIndex = null;
    notifyListeners();
  }
}
