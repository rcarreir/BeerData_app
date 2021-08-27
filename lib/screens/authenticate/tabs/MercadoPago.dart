import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:tutorial_ninja/shared/PanelDrawer.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MercadoPago extends StatelessWidget {
  final publicKey = "TEST-f5f405ea-b2ae-46c7-a786-0fc7b6aa5b67";
  final quantity = "145.6";

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text('Obtener TOKEN', style: TextStyle(color: Colors.white)),
            color: Colors.black,
            onPressed: () async {
              dynamic bodyRequest = await _makePostRequest();
              Map<String, dynamic> map = jsonDecode(bodyRequest);
              String preferenceId = map['id'];
              getToken(preferenceId);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ],
      ),
    );
  }

  void getToken(String preferenceId) async {
    PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
      publicKey,
      preferenceId,
    );
    print(result.result);
  }

  Future _makePostRequest() async {
    // set up POST request arguments
    String url =
        'https://api.mercadopago.com/checkout/preferences?access_token=TEST-7887548273615108-111918-1e25dc51d7f6ca0e4a095ef2c921465f-19362394';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"items": [{"title": "Recarga de BeerCoins","description": "Carga de saldo en BeerCoins","quantity": 1,"currency_id": "ARS","unit_price": $quantity}],"payer":{"email": "payer@email.com"},"payment_methods":{"excluded_payment_types":[{"id":"ticket"},{"id":"atm"}]}}';

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
}
