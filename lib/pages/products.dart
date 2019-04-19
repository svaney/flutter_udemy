import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/scoped-models/main.dart';
import 'package:udemy_app/widgets/products/products.dart';
import 'package:udemy_app/widgets/ui_elements/logout_listtile.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: model.displayFavorites
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  model.toggleFavorites();
                },
              );
            },
          ),
        ],
      ),
      body: _buildProductList(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('Manage Products'),
            leading: Icon(Icons.edit),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = model.isLoading
            ? _buildLoader()
            : (model.displayedProducts.length == 0
                ? _buildNoProductsWidget()
                : Products());

        return RefreshIndicator(onRefresh: model.fetchProducts, child: content);
      },
    );
  }

  Widget _buildNoProductsWidget() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[Center(child: Text('No Products Found'))],
      ),
    );
  }

  Widget _buildLoader() {
    return Center(child: CircularProgressIndicator());
  }
}
