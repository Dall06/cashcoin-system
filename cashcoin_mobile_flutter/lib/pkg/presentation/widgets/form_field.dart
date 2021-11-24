import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:flutter/material.dart';

class CFormField extends StatefulWidget {
  final String? label;
  final IconData? prefIcn;
  final int type;
  final bool? obscured;
  final int ftype;
  final onChange;

  const CFormField(
      {Key? key, this.label, required this.prefIcn, required this.type, this.obscured, required this.ftype, required this.onChange})
      : super(key: key);

  @override
  _CFormFieldState createState() => _CFormFieldState();
}

class _CFormFieldState extends State<CFormField> {
  IconData? obscuredIcon = Icons.visibility_off;
  bool isObscured = false;
  late int type;

  _changeObscured() {
    if(isObscured == true) {
      setState(() {
        isObscured = false;
      });
    } else {
      setState(() {
        isObscured = true;
      });
    }
  }

  _checkSuffixIcon() {
    if(isObscured == true) {
      return Icons.visibility_off;
    }
    return Icons.visibility;
  }

  dynamic _suffValidation() {
    if (widget.type == 1) {
      return null;
    }
    return IconButton(
      icon: Icon(
        _checkSuffixIcon(),
        size: 18,
        color: Colors.white70,
      ),
      onPressed: () => _changeObscured(),
    );
  }

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscured!;
    type = widget.ftype;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscured,
      decoration: InputDecoration(
        label: Text(widget.label!),
        filled: true,
        fillColor: DarkPalette.lightBlack,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          widget.prefIcn,
          size: 18,
          color: Colors.white70,
        ),
        suffixIcon: _suffValidation(),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: DarkPalette.darkGreen)),
        labelStyle: const TextStyle(fontSize: 13.0, color: Colors.white70),
        focusColor: Colors.white70,
      ),
      style: const TextStyle(color: Colors.white70, fontSize: 14.0),
      onChanged: widget.onChange,
    );
  }
}
