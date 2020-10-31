import 'package:flutter/material.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/authenticate/home/home.dart';
import 'package:tutorial_ninja/screens/cervezas.dart';
import 'package:tutorial_ninja/services/auth.dart';

class MainScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final User user;
  MainScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("¡Hola ${user.name}!"),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text('Cerrar sesión'),
          )
        ],
      ),
      drawer: Drawer(
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
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Cuenta'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.grain),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Cervezas'),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cervezas(user: user)),
                );
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Acerca de'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
