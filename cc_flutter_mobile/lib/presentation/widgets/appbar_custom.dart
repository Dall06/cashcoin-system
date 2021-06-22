import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final Widget child;

  const AppBarCustom({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Palette.darkGreen,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      )),
      flexibleSpace: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: child,
      ),
    );
  }
}
