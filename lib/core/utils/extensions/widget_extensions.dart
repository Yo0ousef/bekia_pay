import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget get center => Center(child: this);

  Widget get expanded => Expanded(child: this);
}
