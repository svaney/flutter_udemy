import 'package:flutter/material.dart';
import 'package:udemy_app/pages/product_edit.dart';
import 'package:udemy_app/pages/product_list.dart';
import 'package:udemy_app/scoped-models/main.dart';

class ProductAdminPage extends StatelessWidget {
  final MainModel model;

  ProductAdminPage(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Edit Product',
                icon: Icon(Icons.create),
              ),
              Tab(
                text: 'My Products',
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(),
            ProductListPage(model),
          ],
        ),
      ),
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
            title: Text('All products'),
            leading: Icon(Icons.shop),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          ),
        ],
      ),
    );
  }
}
