import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/palette.dart';

class SettingsSecurityCard extends StatelessWidget {
  final VoidCallback onTapPassword;
  final VoidCallback onTap2FA;

  const SettingsSecurityCard({this.onTapPassword, this.onTap2FA});

  _throwError(BuildContext context, String message) {
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
            ListTile(
              title: Text('Change password',
                  style: TextStyle(color: Colors.white70)),
              trailing: Icon(
                Icons.lock_outline,
                color: Colors.white24,
              ),
              onTap: this.onTapPassword,
            ),
            ListTile(
              title: Text('Double authentication factor',
                  style: TextStyle(color: Colors.white70)),
              trailing: Icon(
                Icons.security,
                color: Colors.white24,
              ),
              onTap: () => _throwError(context, 'Not implemented'),
            ),
          ],
        ),
      ),
    );
  }
}
