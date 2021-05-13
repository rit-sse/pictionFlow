import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'guessCanvas.dart';

Widget text(
    String txt,
    Color colorBackground,
    Color colorText,
    double minWidth,
    double maxWidth,
    double minHeight,
    double maxHeight,
    double fontSize,
    int maxLines) {
  Container textContainer = Container(
    color: colorBackground,
    child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          maxHeight: maxHeight,
        ),
        child: AutoSizeText(
          txt,
          style: TextStyle(
            fontSize: fontSize,
            color: colorText,
            fontFamily: 'Pangolin',
          ),
          maxLines: maxLines,
          textAlign: TextAlign.center,
        )),
  );
  return textContainer;
}

Widget makeImageButton(
    String image, Color color, String drawObject, BuildContext context) {
  var name = image.split(".")[0].replaceAll("_", " ");
  return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: color,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Ink.image(
                image: AssetImage("assets/" + image),
                child: InkWell(
                  onTap: () {
                    drawObject = name;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuessCanvas(drawObject)));
                  },
                )),
            Text(name, style: TextStyle(fontFamily: 'Pangolin'))
          ],
        ),
      ));
}

class ChoosePage extends StatelessWidget {
  String drawObject;

  ChoosePage(String drawObject) {
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
          color: Colors.indigo[300],
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                text("Pick an object to draw!", Colors.indigo[300],
                    Colors.black, 300, 300, 30, 100, 30, 1),
                SizedBox(height: 20),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      makeImageButton(
                          "Bicyle.png", Colors.white, drawObject, context),
                      makeImageButton(
                          "Ice_Cream.png", Colors.white, drawObject, context),
                      makeImageButton(
                          "Shoe.png", Colors.white, drawObject, context),
                      makeImageButton(
                          "Cat.png", Colors.white, drawObject, context),
                      makeImageButton(
                          "Car.png", Colors.white, drawObject, context),
                      makeImageButton(
                          "Toothbrush.png", Colors.white, drawObject, context),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
