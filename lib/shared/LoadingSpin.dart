import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        child: Center(
          child: SpinKitThreeBounce(color: Colors.red, size: 30.0),
        ));
  }
}
