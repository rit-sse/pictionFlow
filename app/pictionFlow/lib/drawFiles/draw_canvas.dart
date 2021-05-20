import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'points_state.dart';
import 'current_path_paint.dart';

var color = Colors.red;

void changeColor(Color newColor) {
  color = newColor;
}

class DrawCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: Icon(Icons.menu),
          leadingWidth: 50,
          foregroundColor: Colors.purple,
        ),
        Container(
          height: 600,
          color: Colors.white,
          child: Consumer<CanvasPathsState>(
              builder: (_, model, child) =>
                  Stack(fit: StackFit.expand, children: [
                    RepaintBoundary(
                      child: CustomPaint(
                        isComplex: true,
                        painter: DrawzoCanvasPainter(model.points),
                        child: Container(),
                      ),
                    ),
                    child
                  ]),
              child: ChangeNotifierProvider(
                create: (_) => CurrentPathState(),
                child: CurrentPathPaint(color),
              )),
        ),
        Container(
            height: MediaQuery.of(context).size.height - 680,
            child: IconButton(
              icon: Icon(Icons.info),
              onPressed: () => changeColor(Colors.blue),
              color: Colors.black,
            )),
      ],
    );
  }
}

class DrawzoCanvasPainter extends CustomPainter {
  List<List<Offset>> points;

  DrawzoCanvasPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3.0
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final pointsSet in points) {
      canvas.drawPoints(PointMode.polygon, pointsSet, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
