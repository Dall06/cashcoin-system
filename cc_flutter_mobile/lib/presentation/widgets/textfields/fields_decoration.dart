import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class FieldsDecorations {
  String label;
  IconData prefixIconData;
  Widget suffixIconData;

  FieldsDecorations({
    this.label,
    this.prefixIconData,
    this.suffixIconData
  });

  InputDecoration buildTextFieldDecoration() {
    return  InputDecoration(
      filled: true,
      fillColor: Palette.lightBlack,
      labelText: this.label,
      prefixIcon: Icon(
        this.prefixIconData,
        size: 18,
        color: Colors.white70,
      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white70)),
      suffixIcon: this.suffixIconData,
      labelStyle: TextStyle(fontSize: 13.0, color: Colors.white70),
      focusColor: Colors.white70,
    );
  }
}