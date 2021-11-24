import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SettingsTile({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(color: Colors.white70, fontSize: 18)),
      trailing: const Icon(Icons.arrow_right, color: Colors.white70),
      onTap: onTap,
    );
  }
}
