import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/pages/auth.dart';
import 'package:udemy_app/pages/product.dart';
import 'package:udemy_app/pages/product_admin.dart';
import 'package:udemy_app/pages/products.dart';
import 'package:udemy_app/scoped-models/main.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    super.initState();
    _model.autoAuthenticate();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.purpleAccent,
          buttonColor: Colors.purpleAccent,
        ),
        //    home: AuthPage(),
        routes: {
          '/': (BuildContext context) =>
              _model.user == null ? AuthPage() : ProductsPage(_model),
          '/products': (BuildContext context) => ProductsPage(_model),
          '/admin': (BuildContext context) => ProductAdminPage(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }

          if (pathElements[1] == 'product') {
            String productId = pathElements[2];
            _model.selectedProduct(productId);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductPage(_model.allProducts.firstWhere((Product pr) {
                    return pr.id == productId;
                  })),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(_model));
        },
      ),
    );
  }
}
