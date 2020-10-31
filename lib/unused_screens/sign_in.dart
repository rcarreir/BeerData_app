import 'package:flutter/material.dart';
import 'package:tutorial_ninja/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

//text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Iniciar sesión'),
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          margin: EdgeInsets.only(left: 1.0, right: 10.0),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Ingresa un correo electrónico.' : null,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    icon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[200], width: 2.0),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    validator: (val) => val.length < 6
                        ? 'La contraseña debe tener al menos 6 caractéres'
                        : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.vpn_key),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[200], width: 2.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => password = val);
                    }),
                SizedBox(height: 30.0),
                RaisedButton(
                    color: Colors.red[400],
                    child: Text('Iniciar sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.loginEmailandPassword(email, password);
                        if (result == null) {
                          setState(() =>
                              error = 'Usuario y/o contraseña incorrecta.');
                        }
                      }
                    }),
                SizedBox(
                  height: 14.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ),
              ]))),
    );
  }
}
