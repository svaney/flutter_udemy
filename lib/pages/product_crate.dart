import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage({this.addProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _productTitle;
  String _productDescription;
  double _productPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildPriceTextField(),
          _buildDescriptionTextField(),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: _onCreateProductClick,
          ),
        ],
      ),
    );
  }

  void _onCreateProductClick() {
    final Map<String, dynamic> pr = {
      'title': _productTitle,
      'description': _productDescription,
      'price': _productPrice,
      'image': 'assets/images/food.jpg'
    };
    widget.addProduct(pr);

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Title'),
      onChanged: (String value) {
        setState(() {
          _productTitle = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      onChanged: (String value) {
        setState(() {
          _productDescription = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        setState(() {
          _productPrice = double.parse(value);
        });
      },
    );
  }
}
