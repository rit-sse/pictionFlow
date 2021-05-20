import 'dart:ui';

import 'points_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var color;

class CurrentPathPaint extends StatelessWidget {
  CurrentPathPaint(Color newColor) {
    color = newColor;
  }

  @override
  Widget build(BuildContext context) {
    CurrentPathState currentPointsState =
        Provider.of<CurrentPathState>(context, listen: false);
    CanvasPathsState mainPointsState =
        Provider.of<CanvasPathsState>(context, listen: false);

    return Consumer<CurrentPathState>(
      builder: (_, model, child) => Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
              child: CustomPaint(
            isComplex: true,
            painter: CurrentPathPainter(model.points),
            child: Container(),
          )),
          child
        ],
      ),
      child: GestureDetector(
          onPanStart: (details) =>
              currentPointsState.addPoint(details.localPosition),
          onPanUpdate: (details) {
            if (details.localPosition.dy < 600 &&
                details.localPosition.dy > 0) {
              currentPointsState.addPoint(details.localPosition);
            }
          },
          onPanEnd: (details) {
            print("redrawing");
            print(mainPointsState.points.length);
            mainPointsState.addPath(currentPointsState.points);
            currentPointsState.resetPoints();
          }),
    );
  }
}

class CurrentPathPainter extends CustomPainter {
  List<Offset> points;

  CurrentPathPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
