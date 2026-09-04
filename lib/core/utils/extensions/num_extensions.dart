import 'package:flutter/material.dart';

extension NumExtensions on num {
  /// Gaps
  SizedBox get hGap => SizedBox(width: toDouble());

  SizedBox get vGap => SizedBox(height: toDouble());

  SizedBox get squareGap => SizedBox(width: toDouble(), height: toDouble());

  /// Durations
  Duration get sec => Duration(seconds: toInt());

  Duration get min => Duration(minutes: toInt());

  Duration get milSec => Duration(milliseconds: toInt());
}
