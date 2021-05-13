import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditWidget extends StatelessWidget {
  String title;
  String content;
  CreditWidget(String title, String content) {
    this.title = title;
    this.content = content;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 30,
            title: RichText(
                text: TextSpan(
              text: this.title,
              children: [
                TextSpan(
                  text: 'Thank You!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "courier"),
                ),
              ],
            )),
          ),
          Text("\n"),
          Text("Designed By:\n"),
          Text("Joseph Casale and Quinn Trafas, RIT\n"),
        ],
      ),
      width: 300,
      height: 600,
      decoration: new BoxDecoration(
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor.withOpacity(.6),
            blurRadius: 35.0,
            spreadRadius: 30.0,
          ),
        ],
      ),
    );
  }
}
