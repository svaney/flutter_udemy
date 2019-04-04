import 'package:flutter/material.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/widgets/products/products.dart';

class ProductsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: Products(),
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
        ],
      ),
    );
  }
}
