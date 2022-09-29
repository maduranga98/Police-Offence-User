// ignore_for_file: camel_case_types

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class dataseries {
  final String type;
  final int value;
  final charts.Color barcolor;
  dataseries({required this.type, required this.value, required this.barcolor});
}

class ChartData {
  final String x;
  final double y;
  final Color color;
  ChartData({required this.x, required this.y, required this.color});
}
