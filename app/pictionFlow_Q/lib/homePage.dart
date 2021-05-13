import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  String drawObject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.8),
                colors: <Color>[Colors.indigo, Colors.white],
                tileMode: TileMode.repeated),
          ),
          child: Image.asset("assets/Profile.png"),
        ),
      ),
    );
  }
}
