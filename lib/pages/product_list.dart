import 'package:flutter/material.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final Function deleteProduct;
  final List<Product> products;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(index.toString()),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction){
            if (direction == DismissDirection.startToEnd) {
              deleteProduct(index);
            }
          },
          child: Column(
            children: <Widget>[
              _buildListItem(context, index),
              Divider(),
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _onEditClick(context, index),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            products[index].image,
          ),
        ),
        title: Text(products[index].title),
        subtitle: Text('\$ ' + products[index].price.toString()),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            _onEditClick(context, index);
          },
        ),
      ),
    );
  }

  void _onEditClick(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductEditPage(
            product: products[index],
            updateProduct: updateProduct,
            index: index,
          );
        },
      ),
    );
  }
}
