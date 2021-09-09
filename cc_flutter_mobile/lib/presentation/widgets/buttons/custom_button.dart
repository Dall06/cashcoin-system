import 'package:flutter/material.dart';
// My packages
import 'package:cc_flutter_mobile/config/palette.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final int buttonType;
  final Widget image;

  CustomButton({
    @required this.title,
    @required this.onPressed,
    @required this.buttonType,
    this.image,
  })  : assert(title != null),
        assert(buttonType != null);

  Color _buttonTypeValidationAction() {
    switch (this.buttonType) {
      case 0:
        return Palette.lightGreen;
      case 1:
        return Palette.redWarning;
      case 2:
        return Palette.yellowWarning;
      case 3:
        return Palette.googleBlue;
      case 4:
        return Palette.darkGreen;
      default:
        return Palette.lightGreen;
    }
  }

  Widget _validateButtonType() {
    if (image == null) {
      return Text(
        this.title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: image,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          this.title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RawMaterialButton(
        elevation: 4,
        fillColor: _buttonTypeValidationAction(),
        splashColor: Palette.lightBlack,
        onPressed: () => onPressed(),
        child: Center(
            widthFactor: 6, heightFactor: 3, child: _validateButtonType()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
