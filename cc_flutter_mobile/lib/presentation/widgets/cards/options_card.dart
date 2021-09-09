import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//  My packages
import 'package:cc_flutter_mobile/config/palette.dart';

class OptionsCard extends StatelessWidget {
  final Function onTap;
  final String primaryText;
  final String blueText;

  OptionsCard(
      {@required this.onTap,
      @required this.primaryText,
      @required this.blueText});

  RichText _buildBottomRichText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.white60,
          fontSize: 16.0,
        ),
        children: <TextSpan>[
          TextSpan(text: primaryText),
          TextSpan(
            text: ' ' + blueText,
            style: TextStyle(
              color: Palette.grayDark,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.lightGreen,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: this.onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(child: _buildBottomRichText()),
        ),
      ),
    );
  }
}
