import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];

  int _selectedProductIndex;

  List<Product> get products {
    return List.from(_products);
  }

  void addProduct(Product product) {
    _products.add(product);
    setSelectedProductIndex(null);
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    setSelectedProductIndex(null);
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    setSelectedProductIndex(null);
    notifyListeners();
  }

  void setSelectedProductIndex(int value) {
    _selectedProductIndex = value;
  }

  int getSelectedProductIndex() {
    return _selectedProductIndex;
  }

  Product getSelectedProduct() {
    return _selectedProductIndex != null
        ? products[_selectedProductIndex]
        : null;
  }

  void toggleProductFavorite() {
    Product currProduct = _products[_selectedProductIndex];
    final Product newProduct = Product(
        title: currProduct.title,
        image: currProduct.image,
        description: currProduct.description,
        price: currProduct.price,
        isFavorite: !currProduct.isFavorite);
    _products[_selectedProductIndex] = newProduct;
    _selectedProductIndex = null;
    notifyListeners();
  }
}
