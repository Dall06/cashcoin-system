import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/providers/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterTile extends ConsumerStatefulWidget {
  const FilterTile({Key? key}) : super(key: key);

  @override
  _FilterTileState createState() => _FilterTileState();
}

class _FilterTileState extends ConsumerState<FilterTile> {
  final List<bool> _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("show me",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 30,
            child: Theme(
              data: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                    selectionColor: Colors.red,
                    selectionHandleColor: Colors.red),
              ),
              child: ToggleButtons(
                onPressed: (int index) {
                  for (int i = 0; i < _isSelected.length; i++) {
                    if (i != index) {
                      setState(() {
                        _isSelected[i] = false;
                      });
                    }
                    if (i == index) {
                      setState(() {
                        _isSelected[i] = true;
                        switch (index) {
                          case 0:
                            ref.read(filterProvider.notifier).state = Filter.all;
                            break;
                          case 1:
                            ref.read(filterProvider.notifier).state = Filter.withdraws;
                            break;
                          case 2:
                            ref.read(filterProvider.notifier).state = Filter.deposits;
                            break;
                        }
                      });
                    }
                  }
                },
                isSelected: _isSelected,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: const Center(
                          child: Text(
                        'all',
                        style: TextStyle(color: Colors.white60),
                      ))),
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: const Center(
                          child: Text(
                        'withdraws',
                        style: TextStyle(color: Colors.white60),
                      ))),
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: const Center(
                          child: Text(
                        'deposits',
                        style: TextStyle(color: Colors.white60),
                      ))),
                ],
                borderRadius: BorderRadius.circular(10),
                fillColor: DarkPalette.darkGreen,
                // renderBorder: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
