import 'package:tutorial_ninja/screens/authenticate/tabs/MainScreen.dart';
import 'package:tutorial_ninja/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_ninja/services/auth.dart';
import 'package:tutorial_ninja/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
