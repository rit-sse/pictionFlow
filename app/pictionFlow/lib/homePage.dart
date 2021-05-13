import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget makeImageButton(
    String text, Color color1, Color color2, BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(150),
    ),
    margin: EdgeInsets.all(20),
    child: Container(
      height: 200,
      width: 200,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(fontFamily: 'Pangolin')),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  String drawObject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 0.8),
              colors: <Color>[Colors.indigo, Colors.white],
              tileMode: TileMode.repeated),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Image.asset("assets/Profile.png"),
              makeImageButton("Play (AI)", Colors.red, Colors.orange, context),
            ],
          ),
        ),
      ),
    );
  }
}
