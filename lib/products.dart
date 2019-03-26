import 'package:flutter/material.dart';
import 'package:udemy_app/pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products({this.products});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(products[index]['title']),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  child: Text('Details'),
                  onPressed: () => Navigator.pushNamed(
                      context, '/product/' + index.toString())),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: _buildProductItem,
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
