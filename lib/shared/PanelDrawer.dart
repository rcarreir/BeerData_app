import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/AboutScreen.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/Account.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/MainScreen.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/Cervezas.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/MercadoPago.dart';

class PanelDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
              // accountEmail: Text("${user.email}"),
              // accountName: Text("${user.name}"),
              accountEmail: Text("Email"),
              accountName: Text("Nombre"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile-logo.png"),
                backgroundColor: Colors.grey[200],
                radius: 100.0,
              )),
          ListTile(
            leading: Icon(Icons.home),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Cuenta'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Account()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.grain),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Cervezas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Cervezas()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Mercado Pago'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MercadoPago()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text('Acerca de'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
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
