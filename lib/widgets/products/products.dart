import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/scoped-models/products.dart';
import 'package:udemy_app/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return _buildList(model.products);
      },
    );
  }

  Widget _buildList(List<Product> products) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          ProductCard(products[index], index),
      itemCount: products.length,
    );
  }
}
