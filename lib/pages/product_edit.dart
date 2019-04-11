import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/models/product.dart';
import 'package:udemy_app/scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Product product = model.getSelectedProduct();
        return model.selectedProductIndex == -1
            ? _buildPage(product, model)
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: _buildPage(product, model),
              );
      },
    );
  }

  Widget _buildPage(Product product, MainModel model) {
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
              _buildTitleTextField(product),
              _buildPriceTextField(product),
              _buildDescriptionTextField(product),
              SizedBox(height: 10.0),
              _buildSubmitButton(product, model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(Product product, MainModel model) {
    return model.isLoading
        ? Center(child: CircularProgressIndicator())
        : RaisedButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: () => _onCreateProductClick(product, model),
          );
  }

  void _onCreateProductClick(Product product, MainModel model) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (model.selectedProductIndex == -1) {
      model
          .addProduct(
        title: _formData['title'],
        price: _formData['price'],
        image: _formData['image'],
        desc: _formData['description'],
      )
          .then((bool success) {
            if (success) {
              Navigator.pushReplacementNamed(context, '/products').then((_) {
                model.selectedProduct(null);
              });
            } else {
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(title: Text('something went wrong'), content: Text('please try again'),);
              });
            }
      });
    } else {
      model
          .updateProduct(
        title: _formData['title'],
        price: _formData['price'],
        image: _formData['image'],
        desc: _formData['description'],
      )
          .then((_) {
        Navigator.pushReplacementNamed(context, '/products')
            .then((_) => model.selectedProduct(null));
      });
    }
  }

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: product == null ? '' : product.title,
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

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      initialValue: product == null ? '' : product.description,
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

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      initialValue: product == null ? '' : product.price.toString(),
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
