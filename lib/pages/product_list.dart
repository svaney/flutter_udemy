import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/pages/product_edit.dart';
import 'package:udemy_app/scoped-models/main.dart';
import 'package:udemy_app/scoped-models/products.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allProducts[index].title),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) {
                model.setSelectedProductIndex(index);
                model.deleteProduct();
              },
              child: Column(
                children: <Widget>[
                  _buildListItem(context, index, model),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, int index, MainModel model) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          model.allProducts[index].image,
        ),
      ),
      title: Text(model.allProducts[index].title),
      subtitle: Text('\$ ' + model.allProducts[index].price.toString()),
      trailing: _buildEdictIconButton(index, context, model),
    );
  }

  Widget _buildEdictIconButton(int index, BuildContext context, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.setSelectedProductIndex(index);
        _onEditClick(context);
      },
    );
  }

  void _onEditClick(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductEditPage();
        },
      ),
    );
  }
}
