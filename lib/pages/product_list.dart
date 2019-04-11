import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/pages/product_edit.dart';
import 'package:udemy_app/scoped-models/main.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return ProductListPageState();
  }
}

class ProductListPageState extends State<ProductListPage>{

  @override
  void initState() {
    super.initState();
    widget.model.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allProducts[index].id),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) {
                model.selectedProduct(model.allProducts[index].id);
                model.deleteProduct();
                model.selectedProduct(null);
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
        backgroundImage: NetworkImage(
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
        model.selectedProduct(model.allProducts[index].id);
        _onEditClick(context, model);
      },
    );
  }

  void _onEditClick(BuildContext context, MainModel model) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductEditPage();
        },
      ),
    ).then((_) {
      model.selectedProduct(null);
    });;
  }
}
