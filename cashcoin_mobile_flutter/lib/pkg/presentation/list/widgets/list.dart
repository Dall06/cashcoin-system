import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:flutter/material.dart';

class ListArea extends StatefulWidget {
  const ListArea({Key? key}) : super(key: key);

  @override
  _ListAreaState createState() => _ListAreaState();

}

class _ListAreaState extends State<ListArea> {
  final List<bool> _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const ListTile(
            title: Text("movements", style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Theme(
            data: ThemeData(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: DarkPalette.lightGreen),
            ),
            child: SizedBox(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                children: const <Widget>[
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
