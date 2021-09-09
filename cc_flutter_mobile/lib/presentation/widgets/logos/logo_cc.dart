import 'dart:math';

import 'package:flutter/material.dart';

class LogoCCWidget extends StatelessWidget {
  final Color color;
  final Widget image;

  const LogoCCWidget({this.color, this.image})
      : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(angle: -pi / 4, child: image);
  }
}
