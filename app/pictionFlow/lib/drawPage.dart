import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawFiles/draw_canvas.dart';

class DrawPage extends StatefulWidget {
  DrawPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrawCanvas(),
    );
  }
}
