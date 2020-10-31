import 'package:flutter/material.dart';
import 'package:tutorial_ninja/unused_screens/register.dart';
import 'package:tutorial_ninja/unused_screens/sign_in.dart';
import 'package:tutorial_ninja/unused_screens/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
    ;
  }
}
