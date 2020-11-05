import 'package:flutter/material.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/authenticate/home/MainScreen.dart';
import 'package:tutorial_ninja/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'PanelDrawer.dart';

class Cervezas extends StatefulWidget {
  final User user;
  Cervezas({this.user});

  @override
  _CervezasState createState() => _CervezasState();
}

class _CervezasState extends State<Cervezas> {
  final AuthService _auth = AuthService();
  final databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController qrCanilla = TextEditingController();
  Future qrCanillaCam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Comprar cerveza'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: qrCanilla,
                decoration: InputDecoration(
                  labelText: 'Ingresar número de canilla',
                  icon: Icon(Icons.access_time),
                  fillColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'o',
                style: TextStyle(color: Colors.grey, fontSize: 21),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text('ESCANEAR QR'),
                color: Colors.red,
                onPressed: () {
                  qrCanillaCam = scanQRCode();
                  /*
                  setState(() {
                    _canillaText = qrCanillaCam as String;
                  });*/
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                qrCanillaCam,
                style: TextStyle(color: Colors.black, fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 250,
              ),
              RaisedButton(
                child: Text('CREAR PEDIDO'),
                color: Colors.red,
                onPressed: () {
                  updateData(qrCanilla.text);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              SizedBox(
                height: 8,
              ),
              RaisedButton(
                child: Text('EXIT', style: TextStyle(color: Colors.white)),
                color: Colors.black,
                onPressed: () {
                  exitState(qrCanilla.text);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ],
          ),
        ),
      ),
      drawer: PanelDrawer(user: widget.user),
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
    /*
    databaseReference
        .child("flutterDevsTeam1")
        .set({'name': 'Deepak Nishad', 'description': 'Team Lead'});*/
    print('$qrCanillaCam');
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
        .update({'UID': widget.user.uid, 'Estado': 1});
  }

  Future scanQRCode() async {
    String cameraScanResult = await scanner.scan();
  }

  void deleteData() {
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }
}
