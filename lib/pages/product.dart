import 'package:flutter/material.dart';
import 'package:udemy_app/widgets/products/address_tag.dart';
import 'package:udemy_app/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> productInfo;

  ProductPage(this.productInfo);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(productInfo['title']),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(productInfo['image']),
              Container(
                margin: EdgeInsets.all(12),
                child: TitleDefault(
                  productInfo['title'],
                  multiline: true,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildAddressPriceRow(),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  productInfo['description'],
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressPriceRow(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: AddressTag('Tbilisi, Samtskhe-Javakheti, Georgia'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '\$ ' + productInfo['price'].toString(),
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(width: 4.0),
      ],
    );
  }
}
