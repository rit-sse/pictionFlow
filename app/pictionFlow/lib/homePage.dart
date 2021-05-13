import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:pictionFlow/infoScreen.dart';

import 'draw.dart';
import 'draw.dart';
import 'draw.dart';

Widget makeImageButton(String text, double textSize, Color textColor, color1,
    Color color2, double size, Draw action, BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(150),
    ),
    margin: EdgeInsets.all(20),
    child: 
    Stack(
      children: [Container(
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
          style: TextStyle(
              color: textColor, fontSize: textSize, fontFamily: 'Pangolin'),
        ),
      ),
    ),
    InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Draw()));
      },
      child: Container(
        width: size-1,
        height: size-1,
      ),
    ),
    
      ],
  
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
          front: Stack(
            children: [
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
                      Image.asset(
                        "assets/Profile.png",
                        width: 300,
                      ),
                      makeImageButton("Play (AI)", 40, Colors.white, Colors.red,
                          Colors.orange, 200, Draw(), context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          makeImageButton("Free Draw", 25, Colors.white,
                              Colors.blue, Colors.purple, 75, Draw(), context),
                          SizedBox(width: 100),
                          makeImageButton("Free Draw", 25, Colors.white,
                              Colors.blue, Colors.purple, 75, Draw(), context),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                child: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () => cardKey.currentState.toggleCard(),
                  color: Colors.white,
                ),
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
          back: InfoScreen(cardKey)),
    );
  }
}
