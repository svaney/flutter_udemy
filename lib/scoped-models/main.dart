import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/scoped-models/user.dart';
import 'package:udemy_app/scoped-models/products.dart';

class MainModel extends Model with UserModel, ProductsModel {

}