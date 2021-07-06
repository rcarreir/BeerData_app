import 'package:flutter/material.dart';
import 'package:tutorial_ninja/shared/PanelDrawer.dart';
import 'package:tutorial_ninja/services/auth.dart';

class MainScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Inicio"),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      drawer: PanelDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/drawerBackground.png',
                    scale: 2,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "¡Bienvenido a BeerData!",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monofonto',
                            color: Colors.grey[800]),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 4.0,
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 5) * 3.2,
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 28.0),
                child: Text(
                  "",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OfficialBook',
                      color: Colors.grey[800]),
                  textAlign: TextAlign.center,
                ),
              ),
              elevation: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}
