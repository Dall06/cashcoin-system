import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final String? error;
  const ButtonText({Key? key, required this.title, this.error}) : super(key: key);

  _returnTitle() {
    Color color = DarkPalette.darkGreen;
    String t = title;
    if ((error != null && error != 'null') && title == "error: ") {
      color = DarkPalette.redWarning;
      t = title + error!;
    }

    if(title == "loading ...") {
      color = Colors.white60;
    } else if(title == "disable") {
      color = DarkPalette.redWarning;
    }

    return Text(
      t,
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _returnTitle();
  }
}
