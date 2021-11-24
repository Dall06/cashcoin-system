import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataTile extends StatelessWidget {
  final String data;
  const DataTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        tileColor: DarkPalette.lightBlack,
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data,
                style: const TextStyle(
                  color: Colors.white70,
                )),
          ],
        ),
        trailing: IconButton(
            icon: const Icon(Icons.copy, color: Colors.white70),
            onPressed: () {
              const snackBar =
                  SnackBar(content: Text('copied to clipboard c:'));
              Clipboard.setData(ClipboardData(text: data));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }),
      ),
    );
  }
}
