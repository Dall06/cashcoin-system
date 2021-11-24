import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// My packages

class Button extends StatelessWidget {
  final Widget title;
  final VoidCallback? onPress;

  const Button({
    Key? key,
    required this.title,
    this.onPress,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        child: Center(
          widthFactor: 4,
          heightFactor: 2,
          child: title,
        ),
        onPressed: onPress,
      ),
    );
  }
}
