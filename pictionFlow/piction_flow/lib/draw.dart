import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class Draw extends StatefulWidget {
  Draw({Key key, this.title}) : super(key:key);
  final String title;

  @override
  _DrawingState createState() => _DrawingState();
  //the arrow allows us to  define what we're returning separately
}

 class _DrawingState extends State<Draw> {
   Color pencolor = Colors.black;
   double strokeWidth = 2.5;
   List<Point> points = [];
   double opacity = 1.0;
   StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap
       .round;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          padding: const EdgeInsets.only(left: 9.0, right: 9.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45.0),
            color: Colors.blue),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            //child: Column(
              //mainAxisSize: MainAxisSize.min,
                //children: <Widget>[
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            onPressed();  
            
                      }),
                    ],
            //)
              //],
            //)
          ),
        ),
      ),
      ),




       body: GestureDetector(
         onPanUpdate: (details) {
           setState(() {
             RenderBox renderBox = context.findRenderObject();
             points.add(Point(
                 points: renderBox.globalToLocal(details.globalPosition),
                 paint: Paint()
                   ..strokeCap = strokeCap
                   ..isAntiAlias = true
                   ..color = pencolor.withOpacity(opacity)
                   ..strokeWidth = strokeWidth));
           });
         },
         onPanStart: (details) {
           setState(() {
             RenderBox renderBox = context.findRenderObject();
             points.add(Point(
                 points: renderBox.globalToLocal(details.globalPosition),
                 paint: Paint()
                   ..strokeCap = strokeCap
                   ..isAntiAlias = true
                   ..color = pencolor.withOpacity(1.0)
                   ..strokeWidth = strokeWidth));
           });
         },
         onPanEnd: (details) {
           setState(() {
             points.add(null);
           });
         },
         child: CustomPaint(
           size: Size.infinite,
           painter: Painter(
             pointsList: points,

           ),
         ),
       ),
     );

   }


  onPressed() {
     setState(() {
       points.clear();

     });
  }

 }
  class PointProcessor{
    PointProcessor({this.pointsList});
    List<Point> pointsList;
  }

  class Painter extends CustomPainter{
    Painter({this.pointsList});
    List<Point> pointsList;
    List<Offset> offsetPoints = [];
    @override
    void paint(Canvas canvas, Size size){
      for(int i=0; i< pointsList.length-1; i++){
        var p = pointsList[i];
        var p_1 = pointsList[i+1];
        if(pointsList[i] != null && pointsList[i+1] != null){
          print(p.points);
          canvas.drawLine(pointsList[i].points, pointsList[i+1].points,
            pointsList[i].paint);
        }else if(pointsList[i] == null && pointsList[i+1] == null){
          offsetPoints.clear();
          offsetPoints.add(pointsList[i].points);
          offsetPoints.add(Offset(p.points.dx + 0.1, p.points.dy + 0.1));
          canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
        }
      }
    }
    @override
    bool shouldRepaint(Painter oldDelegate) => true;
  }

  class Point {
  Paint paint;
  Offset points;
  Point({this.points, this.paint});
  }

