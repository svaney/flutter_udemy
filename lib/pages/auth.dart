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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =  deviceWidth > 500.0 ? 500.0 :  deviceWidth * 9;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Column(
                children: <Widget>[
                  _buildEmailField(),
                  SizedBox(height: 10.0),
                  _buildPasswordField(),
                  SizedBox(height: 10.0),
                  _buildAcceptTerms(),
                  SizedBox(height: 10.0),
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      image: AssetImage('assets/images/food.jpg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.3),
        BlendMode.dstATop,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'E-mail',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Widget _buildAcceptTerms() {
    return SwitchListTile(
      value: _acceptTerm,
      title: Text('Accept Terms'),
      onChanged: (bool value) {
        setState(() {
          _acceptTerm = value;
        });
      },
    );
  }

  Widget _buildLoginButton() {
    return RaisedButton(
      child: Text('Login'),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: _onLoginClick,
    );
  }

  void _onLoginClick() {
    Navigator.pushReplacementNamed(context, '/products');
  }
}
