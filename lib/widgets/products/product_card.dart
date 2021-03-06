import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/scoped-models/main.dart';
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
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/food.jpg',
            image: product.image,
          ),
          _buildTitlePriceRow(),
          SizedBox(
            height: 4.0,
          ),
          AddressTag('Tbilisi, Samtskhe-Javakheti, Georgia'),
          Text(product.userEmail),
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.pushNamed(
                    context,
                    '/product/' + model.allProducts[productIndex].id,
                  ),
            ),
            IconButton(
              icon: Icon(model.allProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                model.selectedProduct(model.allProducts[productIndex].id);
                model.toggleProductFavorite();
              },
            ),
          ],
        );
      },
    );
  }
}
