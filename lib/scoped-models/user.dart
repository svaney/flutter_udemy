import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/user.dart';
import 'package:udemy_app/scoped-models/ConnectedProducts.dart';

mixin UserModel on ConnectedProducts{


  void login (String email, String password){
    authenticatedUser = User(id: "asdasd", email: email, password: password);
  }

}