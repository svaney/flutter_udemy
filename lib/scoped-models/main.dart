import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/scoped-models/ConnectedProducts.dart';
class MainModel extends Model with ConnectedProductsModel, UserModel, ProductsModel, UtilityModel {

}