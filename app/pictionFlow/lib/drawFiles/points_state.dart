import 'package:flutter/material.dart';

class CanvasPathsState extends ChangeNotifier {
  List<List<Offset>> _points;

  CanvasPathsState() {
    _points = [];
  }

  List<List<Offset>> get points => _points;

  addPath(List<Offset> path) {
    _points.add(path);

    notifyListeners();
  }
}

class CurrentPathState with ChangeNotifier {
  List<Offset> _points;

  CurrentPathState() {
    _points = [];
  }

  List<Offset> get points => _points;

  addPoint(Offset point) {
    _points.add(point);

    notifyListeners();
  }

  resetPoints() {
    _points = [];
    notifyListeners();
  }
}
