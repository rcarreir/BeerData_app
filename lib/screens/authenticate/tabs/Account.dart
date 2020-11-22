import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_ninja/models/UserAccount.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/shared/PanelDrawer.dart';
import 'package:tutorial_ninja/services/auth.dart';

class Account extends StatelessWidget {
  final AuthService _auth = AuthService();
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Cuenta"),
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
      drawer: PanelDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder(
                stream: databaseReference
                    .child("Clientes")
                    .child("Usuario")
                    .child(user.uid)
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    DataSnapshot dbSnapshot = snapshot.data.snapshot;
                    UserAccount userAccount = UserAccount(
                      name: dbSnapshot.value['Nombre'] ?? '',
                      surname: dbSnapshot.value['Apellido'] ?? '',
                      balance: dbSnapshot.value['Saldo'].toDouble() ?? 0.0,
                      email: dbSnapshot.value['Email'] ?? '',
                      consumption:
                          dbSnapshot.value['Consumo'].toDouble() ?? 0.0,
                      number: dbSnapshot.value['Numero'] ?? 0,
                    );
                    return Center(
                        child: Column(children: <Widget>[
                      Text("Bienvenido ${userAccount.name}",
                          style: TextStyle(fontSize: 24.0)),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                          "Tu saldo actual es de ${userAccount.balance} beercoins",
                          style: TextStyle(fontSize: 24.0)),
                      SizedBox(
                        height: 40.0,
                      ),
                      FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.red,
                        onPressed: () => {},
                        child: new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new FlatButton(
                                  onPressed: () => {
                                    databaseReference
                                        .child("Clientes")
                                        .child("Usuario")
                                        .child(user.uid)
                                        .update({
                                      'Saldo': userAccount.balance + 50.0
                                    })
                                  },
                                  padding: EdgeInsets.all(20.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        const IconData(0xea88,
                                            fontFamily: 'icomoon'),
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                      Text(
                                        "Cargar Saldo",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]));
                  } else {
                    return Center(child: Text("Descargando datos"));
                  }
                }),
          ),
        ],
      ),
    );
  }

  UserAccount userAccountFromSnapshot(DataSnapshot snapshot) {
    return snapshot.value.map((field) {
      return UserAccount(
        name: field.data['Nombre'] ?? '',
        surname: field.data['Apellido'] ?? '',
        balance: field.data['Saldo'] ?? '',
        email: field.data['Email'] ?? '',
        consumption: field.data['Consumo'] ?? '',
        number: field.data['Numero'] ?? '',
      );
    });
  }
}
