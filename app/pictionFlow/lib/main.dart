import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';

void main() {
  //WidgetsApp //MaterialApp //CupertinoApp
  String drawObject;
  runApp(MaterialApp(
    //home: ChangeNotifierProvider(
    //  create: (_) => CanvasPathsState(),
    //  child: MyHomePage(title: 'Test'),
    //),
    home: AnimatedSplashScreen(
      splash: Image.asset('assets/solo.png'),
      backgroundColor: Colors.white,
      nextScreen: HomePage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    ),
    title: "pictionFlow",
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}
