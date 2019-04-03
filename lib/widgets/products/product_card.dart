import 'package:flutter/material.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/widgets/products/address_tag.dart';
import 'package:udemy_app/widgets/products/price_tag.dart';
import 'package:udemy_app/widgets/ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          _buildTitlePriceRow(),
          SizedBox(
            height: 4.0,
          ),
          AddressTag('Tbilisi, Samtskhe-Javakheti, Georgia'),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: TitleDefault(product.title),
          ),
          SizedBox(
            width: 8.0,
          ),
          PriceTag(product.price.toString()),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pushNamed(
                context,
                '/product/' + productIndex.toString(),
              ),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Theme.of(context).accentColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
