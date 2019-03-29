import 'package:flutter/material.dart';
import 'package:udemy_app/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products({this.products});

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
      itemCount: products.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return products.length > 0
        ? _buildList()
        : Center(child: Text('No Products, please add some'));
  }
}
