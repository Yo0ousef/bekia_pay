import 'package:flutter/cupertino.dart';

extension ContextExtensions on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;
}
