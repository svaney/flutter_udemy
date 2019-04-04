import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/pages/auth.dart';
import 'package:udemy_app/pages/product.dart';
import 'package:udemy_app/pages/product_admin.dart';
import 'package:udemy_app/pages/products.dart';
import 'package:udemy_app/scoped-models/products.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductsModel>(
      model: ProductsModel(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.purpleAccent,
          buttonColor: Colors.purpleAccent,
        ),
        //    home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(),
          '/admin': (BuildContext context) => ProductAdminPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }

          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage());
        },
      ),
    );
  }
}
