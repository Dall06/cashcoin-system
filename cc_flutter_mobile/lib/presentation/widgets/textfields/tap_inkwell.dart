import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class TapInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const TapInkWell({this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Container(
      child: InkWell(
        splashColor: Palette.lightBlack,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              this.label,
              style: TextStyle(
                  color: Colors.white30, fontSize: 12.0),
            ),
            SizedBox(
              width: space,
            ),
            Icon(
              Icons.touch_app,
              color: Palette.darkGreen,
              size: 16.0,
            ),
          ],
        ),
        onTap: this.onTap,
      ),
    );
  }
}
