import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_ninja/models/user.dart';
import 'package:tutorial_ninja/shared/PanelDrawer.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MercadoPago extends StatefulWidget {
  @override
  _MercadoPagoState createState() => _MercadoPagoState();
}

class _MercadoPagoState extends State<MercadoPago> {
  final publicKey = "TEST-f5f405ea-b2ae-46c7-a786-0fc7b6aa5b67";
  final databaseReference = FirebaseDatabase.instance.reference();

  String reloadAmount = "250";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Mercado Pago"),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      drawer: PanelDrawer(),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                      "Ingresa la cantidad de saldo que queres agregar a tu cuenta.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monofonto',
                          color: Colors.grey[800])),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, right: 40.0, top: 2.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: "ARS ",
                        hintText: '$reloadAmount',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (val) {
                        setState(() => reloadAmount = val);
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            child: Text('Pagar',
                style: TextStyle(color: Colors.white, fontSize: 17)),
            color: Colors.black,
            onPressed: () async {
              dynamic bodyRequest = await _makePostRequest();
              Map<String, dynamic> map = jsonDecode(bodyRequest);
              String preferenceId = map['id'];
              launchCheckout(preferenceId, user);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ],
      ),
    );
  }

  void launchCheckout(String preferenceId, User user) async {
    PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
      publicKey,
      preferenceId,
    );

    if (result.status == 'approved') {
      databaseReference
          .child("Clientes")
          .child("Usuario")
          .child(user.uid)
          .child("Saldo")
          .once()
          .then((DataSnapshot snapshot) {
        double newBalance = snapshot.value + double.parse(reloadAmount);
        updateUserData("Saldo", newBalance, user);
      });

      //String oldBalance = await readCurrentUserBalance(user);
      //print("$oldBalance");
      print("APROBADO");
      //var newBalance = double.parse(oldBalance) + double.parse(reloadAmount);
      //print("$newBalance");
      //updateUserData("Saldo", newBalance, user);
    }
  }

  Future _makePostRequest() async {
    // set up POST request arguments
    String url =
        'https://api.mercadopago.com/checkout/preferences?access_token=TEST-7887548273615108-111918-1e25dc51d7f6ca0e4a095ef2c921465f-19362394';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"items": [{"title": "Recarga de BeerCoins","description": "Carga de saldo en BeerCoins","quantity": 1,"currency_id": "ARS","unit_price": $reloadAmount}],"payer":{"email": "payer@email.com"},"payment_methods":{"excluded_payment_types":[{"id":"ticket"},{"id":"atm"}]}}';

    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    return response.body;
    // {
    //   "title": "Hello",
    //   "body": "body text",
    //   "userId": 1,
    //   "id": 101
    // }
  }

  updateUserData(dynamic campo, dynamic valor, User user) {
    databaseReference
        .child("Clientes")
        .child("Usuario")
        .child(user.uid)
        .update({
      '$campo': valor,
    });
  }

  readCurrentUserBalance(User user) {
    databaseReference
        .child("Clientes")
        .child("Usuario")
        .child(user.uid)
        .child("Saldo")
        .once()
        .then((DataSnapshot snapshot) {
      //print(snapshot.value);
      return snapshot.value;
    });
  }
}
