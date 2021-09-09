import 'package:flutter/material.dart';

import 'fields_decoration.dart';

class CustomTextField extends StatefulWidget {
  final FormFieldSetter<String> onChanged;
  final FormFieldValidator<String> validator;
  final String label;
  final IconData prefixIconData;
  final TextInputType keyBoardType;
  final String initialValue;

  CustomTextField({
    @required this.onChanged,
    this.validator,
    @required this.label,
    @required this.prefixIconData,
    this.keyBoardType,
    this.initialValue,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  IconData _suffixIcon = Icons.visibility_off;

  void _changePassword() {
    if (_obscureText) {
      setState(() {
        _obscureText = false;
        _suffixIcon = Icons.visibility;
      });
      return;
    }
    if (!_obscureText) {
      setState(() {
        _obscureText = true;
        _suffixIcon = Icons.visibility_off;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyBoardType,
      obscureText: (widget.label == 'password' ||
              widget.label == 'confirm password' ||
              widget.label == 'new password' ||
              widget.label == 'current password')
          ? _obscureText
          : false,
      initialValue: widget.initialValue,
      decoration: FieldsDecorations(
        label: widget.label,
        prefixIconData: widget.prefixIconData,
        suffixIconData:
            (widget.label == 'password' || widget.label == 'confirm password')
                ? IconButton(
                    onPressed: _changePassword,
                    icon: Icon(
                      this._suffixIcon,
                      size: 18,
                      color: Colors.white70,
                    ),
                  )
                : null,
      ).buildTextFieldDecoration(),
      style: TextStyle(color: Colors.white70, fontSize: 14.0),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
