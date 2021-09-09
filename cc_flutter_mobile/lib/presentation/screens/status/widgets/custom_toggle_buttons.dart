import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class CustomToggleButtons extends StatefulWidget {
  final Function setOption;
  final List<bool> isSelected;

  const CustomToggleButtons(
      {Key key, @required this.setOption, @required this.isSelected})
      : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ToggleButtons(
        onPressed: widget.setOption,
        isSelected: widget.isSelected,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                  child: Text(
                'All',
                style: TextStyle(color: Colors.white60),
              ))),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                  child: Text(
                'Transfers',
                style: TextStyle(color: Colors.white60),
              ))),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                  child: Text(
                'Deposits',
                style: TextStyle(color: Colors.white60),
              ))),
        ],
        borderRadius: BorderRadius.circular(10),
        selectedBorderColor: Palette.lightBlack,
        selectedColor: Palette.lightBlack,
        fillColor: Palette.darkGreen,
        // renderBorder: false,
      ),
    );
  }
}
