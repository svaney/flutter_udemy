import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final Map<String, String> productInfo;

  ProductPage(this.productInfo);

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('this action can not be undone'),
            actions: <Widget>[
              FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('DELETE'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

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
        body: Column(
          children: <Widget>[
            Image.asset(productInfo['image']),
            Container(
              margin: EdgeInsets.all(12),
              child: Text(productInfo['title']),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: () => _showDialog(context),
              child: Text('DELETE'),
            )
          ],
        ),
      ),
    );
  }
}
