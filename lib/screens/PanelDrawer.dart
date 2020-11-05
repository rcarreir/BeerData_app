import 'package:flutter/material.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/AboutScreen.dart';
import 'package:tutorial_ninja/screens/authenticate/home/Account.dart';
import 'package:tutorial_ninja/screens/authenticate/home/MainScreen.dart';
import 'package:tutorial_ninja/screens/authenticate/home/home.dart';
import 'package:tutorial_ninja/screens/cervezas.dart';

class PanelDrawer extends StatelessWidget {
  PanelDrawer({this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/drawerBackground.png"),
                ),
              ),
              accountEmail: Text(user.email),
              accountName: Text("${user.name}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/cristina.jpg"),
              )),
          ListTile(
            leading: Icon(Icons.home),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen(user: user)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Cuenta'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Account(user: user)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.grain),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Cervezas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cervezas(user: user)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Acerca de'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
