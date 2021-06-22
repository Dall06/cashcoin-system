import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class CloseAccountAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Palette.lightGreen,
      title: const Text(
        'Close Account instructions',
        style: TextStyle(color: Palette.blackBg),
      ),
      content: const Text(
        'Please check that your account does not have saving left. '
            '\nThen contact support to make a close solicitude...'
            'Remember this process if for ensure a secure service to all of the users',
        style: TextStyle(color: Colors.white70),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text(
            'OK',
            style: TextStyle(color: Palette.grayDark),
          ),
        ),
      ],
    );
  }
}
