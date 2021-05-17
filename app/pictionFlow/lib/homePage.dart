import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget makeImageButton(String text, double textSize, Color textColor, color1,
    Color color2, double size, BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(150),
    ),
    margin: EdgeInsets.all(20),
    child: InkWell(
      onTap: () {
        print("TEST");
      },
      child: Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: textSize),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  String drawObject;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlipCard(
      key: cardKey,
      flipOnTouch: false,
      direction: FlipDirection.HORIZONTAL,
      front: Stack(children: [
        Container(
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
                SizedBox(height: 100),
                Image.asset(
                  "assets/Profile.png",
                ),
                SizedBox(height: 50),
                makeImageButton("Play (AI)", 40, Colors.white, Colors.red,
                    Colors.orange, 200, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    makeImageButton("Free Draw", 20, Colors.white, Colors.blue,
                        Colors.purple, 100, context),
                    SizedBox(width: 100),
                    makeImageButton("Alpha 0.1", 20, Colors.white, Colors.blue,
                        Colors.purple, 100, context),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () => cardKey.currentState.toggleCard(),
            icon: Icon(Icons.info),
            color: Colors.white,
          ),
        ),
      ]),
      back: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.8),
                colors: <Color>[Colors.blue[300], Colors.green[50]],
                tileMode: TileMode.repeated),
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Joe C"),
                      SizedBox(height: 20),
                      Text("Quinn T"),
                      SizedBox(height: 100),
                      Text("https://github.com/rit-sse/pictionFlow"),
                      SizedBox(height: 20),
                      Text("Supported by SSE")
                    ],
                  )),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () => cardKey.currentState.toggleCard(),
                  icon: Icon(Icons.home),
                  color: Colors.white,
                ),
              ),
            ],
          )),
    ));
  }
}
