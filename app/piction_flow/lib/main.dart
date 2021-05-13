import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:piction_flow/draw.dart';

void main() => runApp(DrawApp());

class DrawApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'pictionFlow',
      home: Draw(),
    );
  }
}