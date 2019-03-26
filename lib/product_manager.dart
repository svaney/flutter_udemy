import 'package:flutter/material.dart';
import 'package:udemy_app/product_control.dart';
import 'package:udemy_app/products.dart';

class ProductManager extends StatelessWidget {
  final List <Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8.0),
          child: ProductControl(addProduct),
        ),
        Expanded(
            child:
                Products(products: products, deleteProduct: deleteProduct)),
      ],
    );
  }
}
