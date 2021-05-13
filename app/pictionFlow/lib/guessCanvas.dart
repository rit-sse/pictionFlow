import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'draw.dart';

class CurrentGuess extends StatefulWidget {
  @override
  _CurrentGuessState createState() => _CurrentGuessState();
}

class _CurrentGuessState extends State<CurrentGuess> {
  String guess = "...";
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 5),
      ),
      child: Text(
        guess,
        style: (TextStyle(
          fontFamily: 'Pangolin',
          fontSize: 30,
        )),
      ),
    );
  }
}

class GuessCanvas extends StatelessWidget {
  String drawObject;

  GuessCanvas(String drawObject) {
    this.drawObject = drawObject;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pictionFlow"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        color: Colors.indigo[300],
        child: Column(
          children: [
            Text(
              drawObject,
              style: (TextStyle(
                fontFamily: 'Pangolin',
                fontSize: 40,
                color: Colors.white,
              )),
            ),
            SizedBox(height: 10),
            CurrentGuess(),
            SizedBox(height: 10),
            Draw(),
          ],
        ),
      ),
    );
  }
}
