import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_ninja/screens/authenticate/WelcomeScreen.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/authenticate/home/mainScreen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //usuario sin logear
    if (user == null) {
      return WelcomeScreen();
    } else {
      //usuario logeado, entra en la app
      //return Home(user: user);
      return MainScreen(user: user);
    }
  }
}
