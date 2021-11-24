import 'dart:math';

import 'package:cashcoin_mobile_flutter/config/paths.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color? color;
  final String? path;
  final double size;

  const Logo({Key? key, this.color, this.path, required this.size}) : super(key: key);

  _pathToImage(String? path) {
    return AssetImage(LogoPath.asPath(path)!);
  }

  double _returnAngle(String? path) {
    if (path != 'cashcoin') {
      return 0;
    }
    return -pi / 4;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(angle: _returnAngle(path), child: Image(
      width: size,
      height: size,
      image: _pathToImage(path),
    ),);
  }
}