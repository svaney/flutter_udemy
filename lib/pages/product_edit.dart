import 'package:flutter/material.dart';
import 'package:udemy_app/models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final int index;
  final Product product;

  ProductEditPage({
    this.addProduct,
    this.updateProduct,
    this.product,
    this.index,
  });

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/images/food.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return widget.product == null
        ? _buildPage()
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: _buildPage(),
          );
  }

  Widget _buildPage() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
        ),
      ),
    );
  }

  void _onCreateProductClick() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (widget.product == null) {
      widget.addProduct(
        Product(
          title: _formData['title'],
          price: _formData['price'],
          image: _formData['image'],
          description: _formData['description'],
        ),
      );
    } else {
      widget.updateProduct(
        widget.index,
        Product(
          title: _formData['title'],
          price: _formData['price'],
          image: _formData['image'],
          description: _formData['description'],
        ),
      );
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: widget.product == null ? '' : widget.product.title,
      onSaved: (String value) {
        _formData['title'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        }
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      initialValue: widget.product == null ? '' : widget.product.description,
      onSaved: (String value) {
        _formData['description'] = value;
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Description is required and should be at least 5 charachters long';
        }
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return value.isEmpty ? 'Price is required' : 'Price should be number';
        }
      },
    );
  }
}
