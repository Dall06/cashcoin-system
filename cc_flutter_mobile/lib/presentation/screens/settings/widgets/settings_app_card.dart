import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class SettingsAppCard extends StatefulWidget {
  @override
  _SettingsAppCardState createState() => _SettingsAppCardState();
}

class _SettingsAppCardState extends State<SettingsAppCard> {
  bool switchDarkTStatus = true;
  bool switchNotification = false;

  void _throwError(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Palette.lightBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            SwitchListTile(
              activeColor: Palette.lightGreen,
              inactiveThumbColor: Palette.darkGreen,
              value: switchDarkTStatus,
              title: Text(
                'Dark theme',
                style: TextStyle(color: Colors.white70),
              ),
              onChanged: (bool) {
                setState(() {
                  switchDarkTStatus = true;
                });
                _throwError(context, 'Not implemented, just dark theme');
              },
            ),
            SwitchListTile(
                activeColor: Palette.lightGreen,
                inactiveThumbColor: Palette.darkGreen,
                value: switchNotification,
                title: Text(
                  'Receive Notifications',
                  style: TextStyle(color: Colors.white70),
                ),
                onChanged: (bool) {
                  setState(() {
                    switchNotification = false;
                  });
                  _throwError(context, "Not implemented, no notifications");
                }),
          ],
        ),
      ),
    );
  }
}
