import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _password;
  String _email;
  bool _acceptTerm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 10.0),
            SwitchListTile(
              value: _acceptTerm,
              title: Text('Accept Terms'),
              onChanged: (bool value) {
                setState(() {
                  _acceptTerm = value;
                });
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Login'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/products');
              },
            ),
          ],
        ),
      ),
    );
  }
}
