import 'package:flutter/material.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController canilla = TextEditingController();
  final User user;
  Home({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('BeerData Home'),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.arrow_drop_down_circle),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text('Salir'),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /* RaisedButton(
              child: Text('Create Data'),
              color: Colors.redAccent,
              onPressed: () {
                createData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Read/View Data'),
              color: Colors.redAccent,
              onPressed: () {
                readData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),*/
              RaisedButton(
                child: Text('CREAR PEDIDO'),
                color: Colors.red,
                onPressed: () {
                  updateData(canilla.text);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              SizedBox(
                height: 8,
              ),
              /* RaisedButton(
              child: Text('Delete Data'),
              color: Colors.redAccent,
              onPressed: () {
                deleteData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),*/
              TextField(
                controller: canilla,
                decoration: InputDecoration(
                  labelText: 'QR',
                  icon: Icon(Icons.access_time),
                  fillColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text('EXIT', style: TextStyle(color: Colors.white)),
                color: Colors.black,
                onPressed: () {
                  exitState(canilla.text);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ],
          ),
        ),
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
                accountName: Text("Rodrigo Carreira"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/cristina.jpg"),
                )),
            /* DrawerHeader(
              child: Text('Beer Data'),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),*/
            ListTile(
              leading: Icon(Icons.home),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Cuenta'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.grain),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Cervezas'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void exitState(String qr) {
    databaseReference
        .child("Bares")
        .child("BarFalso1")
        .child("Pedido")
        .child(qr)
        .update({'Estado': 0});
  }

  void createData() {
    databaseReference
        .child("flutterDevsTeam1")
        .set({'name': 'Deepak Nishad', 'description': 'Team Lead'});
  }

  void readData() {
    databaseReference
        .child("Clientes")
        .child("Usuario")
        .child("Carlitos")
        .child("Apellido")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values["Apellido"]);
      });
    });
  }

  void updateData(String qr) {
    databaseReference
        .child("Bares")
        .child("BarFalso1")
        .child("Pedido")
        .child(qr)
        .update({'UID': user.uid, 'Estado': 1});
  }

  void deleteData() {
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }
}
