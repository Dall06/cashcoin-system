import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Palette.darkGreen,
      color: Palette.lightGreen,
      semanticsLabel: 'Loading Data',
    );
  }
}
