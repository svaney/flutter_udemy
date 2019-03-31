import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _authFormKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'password': null,
    'email': null,
    'acceptTerms' : false,
  };

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 500.0 : deviceWidth * 9;
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
              child: Form(
                key: _authFormKey,
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
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-mail',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _formData['email'] = value;
      },
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please fill with valid E-mail address';
        }
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onSaved: (String value) {
        _formData['password'] = value;
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 4) {
          return 'Password should be at least 4 characters';
        }
      },
    );
  }

  Widget _buildAcceptTerms() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      title: Text('Accept Terms'),
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
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
    if (!_authFormKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _authFormKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/products');
  }
}
