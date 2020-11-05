import 'package:flutter/material.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/PanelDrawer.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acerca de..."),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
            label: Text('Cerrar sesión'),
          )
        ],
      ),
      drawer: PanelDrawer(user: user),
    );
  }
}
