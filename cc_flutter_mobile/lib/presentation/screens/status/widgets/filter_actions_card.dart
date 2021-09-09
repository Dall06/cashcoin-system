import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

import 'custom_toggle_buttons.dart';

class FilterActionsCard extends StatefulWidget {
  final List<bool> isSelected;
  final setOptions;

  const FilterActionsCard({Key key, this.isSelected, this.setOptions}) : super(key: key);

  @override
  _FilterActionsCardState createState() => _FilterActionsCardState();
}

class _FilterActionsCardState extends State<FilterActionsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.lightBlack,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Filters',
              style: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            CustomToggleButtons(
              setOption: widget.setOptions,
              isSelected: widget.isSelected,
            ),
          ],
        ),
      ),
    );
  }
}
