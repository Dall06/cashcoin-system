import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String content;
  final String actionType;
  final IconData icon;

  ActionCard({
    @required this.content,
    @required this.actionType,
    this.title,
    this.icon
  });

  Color get _validateActionType {
    if (this.actionType == 'transaction') {
      return Palette.lightBlack;
    }
    if (this.actionType == 'list') {
      return Palette.darkGreen;
    }
    if (this.actionType == 'deposit') {
      return Palette.lightBlack;
    }
    if (this.actionType == 'settings') {
      return Palette.lightBlack;
    }
    return Palette.greenConfirm;
  }

  @override
  Widget build(BuildContext context) {
    var _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = _height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Card(
      color: _validateActionType,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(actionType),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: actionType != 'list'
                    ? Palette.darkGreen
                    : Palette.blackBg,
                size: 20,
              ),
              SizedBox(
                height: 1.2 * space,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                content,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
