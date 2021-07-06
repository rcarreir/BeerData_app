import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/screens/authenticate/tabs/MainScreen.dart';
import 'package:tutorial_ninja/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../../../shared/PanelDrawer.dart';

class Cervezas extends StatefulWidget {
  @override
  _CervezasState createState() => _CervezasState();
}

class _CervezasState extends State<Cervezas> {
  final AuthService _auth = AuthService();
  final databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController qrCanilla = TextEditingController();
  Future qrCanillaCam;
  String _lecturaQR;
  String _mensajeConectado;
  bool _isButtonEnabled;

  @override
  void initState() {
    super.initState();
    _isButtonEnabled = false;
    _lecturaQR = '';
    _mensajeConectado =
        'Asegurate de estar frente a la canilla para escanear el código QR en pantalla.';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
              /* TextField(
                controller: qrCanilla,
                decoration: InputDecoration(
                  labelText: 'Ingresar número de canilla',
                  icon: Icon(Icons.access_time),
                  fillColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'o',
                style: TextStyle(color: Colors.grey, fontSize: 21),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),*/
              RaisedButton(
                child: Text('ESCANEAR QR'),
                color: Colors.red,
                onPressed: () {
                  qrCanillaCam = scanQRCode(user);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 55.0,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.amber[50],
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 7.0),
                      /*child: Text(
                        'Luego de escanear el código de la canilla, presione Crear Pedido',
                        style: TextStyle(fontSize: 17.0),
                      ),         */
                      child: Text(
                        '$_mensajeConectado',
                        style: TextStyle(fontSize: 18.0),
                      )),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              /*  RaisedButton(
                child: Text('CREAR PEDIDO'),
                color: Colors.red,
                disabledColor: Colors.grey,
                onPressed: _isButtonEnabled
                    ? () => crearPedidoDB(_lecturaQR, user)
                    : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              SizedBox(
                height: 8,
              ),*/
              RaisedButton(
                child: Text('TERMINAR', style: TextStyle(color: Colors.white)),
                color: Colors.black,
                disabledColor: Colors.grey,
                onPressed:
                    _isButtonEnabled ? () => exitState(_lecturaQR, user) : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ],
          ),
        ),
      ),
      drawer: PanelDrawer(),
    );
  }

  void exitState(String qr, User user) {
    databaseReference
        .child("Bares")
        .child("BarFalso1")
        .child("Pedido")
        .child(qr)
        .set({'UID': user.uid, 'Estado': 0});
    setState(() {
      _isButtonEnabled = false;
      _lecturaQR = '';
      _mensajeConectado =
          'Asegurate de estar frente a la canilla para escanear el código QR en pantalla.';
    });
  }

  void crearPedidoDB(String qr, User user) {
    databaseReference
        .child("Bares")
        .child("BarFalso1")
        .child("Pedido")
        .child(qr)
        .set({'UID': user.uid, 'Estado': 1});
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
        .update({/*'UID': widget.user.uid,*/ 'Estado': 1});
  }

  Future scanQRCode(User user) async {
    String temp = await scanner.scan();
    if (temp == 'BeerDataBarFalso1QR2') {
      setState(() {
        _isButtonEnabled = true;
        _lecturaQR = 'QR1';
        crearPedidoDB(_lecturaQR, user);
        _mensajeConectado =
            'Conectado con la canilla 1. Cuando termines de servite presiona TERMINAR.';
      });
    } else if (temp == 'BeerDataBarFalso1QR2') {
      setState(() {
        _isButtonEnabled = true;
        _lecturaQR = 'QR2';
        crearPedidoDB(_lecturaQR, user);
        _mensajeConectado =
            'Conectado con la canilla 2. Cuando termines de servite presiona TERMINAR.';
      });
    } else if (temp == 'BeerDataBarFalso1QR3') {
      setState(() {
        _isButtonEnabled = true;
        _lecturaQR = 'QR3';
        crearPedidoDB(_lecturaQR, user);
        _mensajeConectado =
            'Conectado con la canilla 3. Cuando termines de servite presiona TERMINAR.';
      });
    } else if (temp == 'BeerDataBarFalso1QR4') {
      setState(() {
        _isButtonEnabled = true;
        _lecturaQR = 'QR4';
        crearPedidoDB(_lecturaQR, user);
        _mensajeConectado =
            'Conectado con la canilla 4. Cuando termines de servite presiona TERMINAR.';
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
        _lecturaQR = '';
        _mensajeConectado = 'El QR no es válido. Volve a intentarlo.';
      });
    }
    //databaseReference.update({'TestPedido': lecturaQR});
  }

  void deleteData() {
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }
}
