import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/palette.dart';

class SettingsEditCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const SettingsEditCard({@required this.name, @required this.onTap})
      : assert(name != null, onTap != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Palette.darkGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          title: Text(this.name, style: TextStyle(color: Colors.white70)),
          trailing: Icon(
            Icons.edit,
            color: Palette.blackBg,
          ),
          onTap: this.onTap,
        ),
      ),
    );
  }
}
