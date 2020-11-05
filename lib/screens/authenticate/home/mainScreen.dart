import 'package:flutter/material.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/PanelDrawer.dart';
import 'package:tutorial_ninja/screens/authenticate/home/home.dart';
import 'package:tutorial_ninja/screens/cervezas.dart';
import 'package:tutorial_ninja/services/auth.dart';

class MainScreen extends StatelessWidget {
  MainScreen({this.user});

  final User user;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Inicio"),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      drawer: PanelDrawer(user: user),
    );
  }
}
