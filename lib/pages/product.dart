import 'package:flutter/material.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/widgets/products/address_tag.dart';
import 'package:udemy_app/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.network(product.image),
                Container(
                  margin: EdgeInsets.all(12),
                  child: TitleDefault(
                    product.title,
                    multiline: true,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _buildAddressPriceRow(product.price),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildAddressPriceRow(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: AddressTag('Tbilisi, Samtskhe-Javakheti, Georgia'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '\$ ' + price.toString(),
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(width: 4.0),
      ],
    );
  }
}
