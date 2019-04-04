import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/models/user.dart';

class ConnectedProducts extends Model{
  List<Product> products = [];
  User authenticatedUser;
  int selProductIndex;


  void addProduct({String title, String desc, String image, double price}) {
    Product pr = Product(title: title, image: image, description: desc, price: price)
    products.add(product);
    selProductIndex = null;
    notifyListeners();
  }


}