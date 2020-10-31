import 'package:flutter/material.dart';
import 'package:tutorial_ninja/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

//text field state
  String name = '';
  String surname = '';
  int age = 0;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Registrarse'),
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Ingresá tu nombre.' : null,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    icon: Icon(Icons.person),
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
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Ingresá tu apellido.' : null,
                  decoration: InputDecoration(
                    labelText: 'Apellido',
                    icon: Icon(Icons.person),
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
                    setState(() => surname = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Ingresa un correo electrónico.' : null,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                    child: Text('Registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.registerEmailandPassword(
                            email, password, name, surname, 20.0);
                        if (result == null) {
                          setState(() =>
                              error = 'Ingresá un correo electrónico válido.');
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
