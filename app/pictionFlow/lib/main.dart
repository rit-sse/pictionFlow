import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';

void main() {
  //WidgetsApp //MaterialApp //CupertinoApp
  String drawObject;
  runApp(MaterialApp(
    home: AnimatedSplashScreen(
      splash: Image.asset(
        'assets/solo.png',
      ),
      backgroundColor: Colors.white,
      nextScreen: HomePage(),
      //nextScreen: ChoosePage(drawObject),
      //nextScreen: GuessCanvas(drawObject),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    ),
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
  ));
}