import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products({this.products});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  products[index]['title'],
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald'
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    '\$ ' + products[index]['price'].toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 4.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text('Tbilisi, Samtskhe-Javakheti, Georgia'),
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
