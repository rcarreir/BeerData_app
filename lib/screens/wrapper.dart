import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_ninja/screens/authenticate/home/WelcomeScreen.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/MainScreen.dart';

class Wrapper extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //usuario sin logear
    if (user == null) {
      return WelcomeScreen();
    } else {
      return MainScreen();
    }
  }
}
