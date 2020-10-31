import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomeScreen(),
    ));

class HomeScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BeerData',
          style: TextStyle(
            fontSize: 35.0,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
            fontFamily: 'Abril',
            color: Colors.grey[600],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.amber[300],
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          color: Colors.grey[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email', icon: Icon(Icons.email)),
              ),
              SizedBox(height: 18.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.vpn_key),
                  hoverColor: Colors.amber[300],
                ),
              ),
              SizedBox(height: 18.0),
              FlatButton(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                color: Colors.amber[300],
                textColor: Colors.white,
                onPressed: () {},
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Add'),
        backgroundColor: Colors.amber[300],
      ),
    );
  }
}
