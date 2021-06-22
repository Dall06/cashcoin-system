import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  final String transactionType;
  final int transactionStatus;
  final String concept;
  final num quantity;
  final String from;
  final String to;
  final String date;

  const ListCard({
    @required this.transactionType,
    @required this.transactionStatus,
    @required this.concept,
    @required this.quantity,
    @required this.from,
    @required this.date,
    @required this.to,
  });

  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  Color _iconColor = Palette.blackBg;
  IconData _icon = Icons.lock;

  void _changeIconColor () {
    if(widget.transactionStatus == 0) { //Pending
      setState(() {
        _iconColor = Palette.greenConfirm;
      });
      return;
    }
    if(widget.transactionStatus == 1) { //Not accepted
      setState(() {
        _iconColor = Palette.redWarning;
      });
      return;
    }
    if(widget.transactionStatus == 2) { //Completed
      setState(() {
        _iconColor = Palette.greenConfirm;
      });
      return;
    }
  }

  void _whichIconIs () {
    if(widget.transactionType == 'Deposit') {
      setState(() {
        _icon = Icons.trending_up;
      });
    }
    if(widget.transactionType == 'Transfer') {
      setState(() {
        _icon = Icons.trending_down;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _changeIconColor();
    _whichIconIs();
  }

  @override
  Widget build(BuildContext context) {
    var _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = _height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Card(
      margin: EdgeInsets.only(bottom: space),
      color: Palette.lightBlack,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: Icon(_icon, color: _iconColor),
        title: Text(
          'Concept ' + widget.concept,
          style: TextStyle(color: Colors.white70),
        ),
        subtitle: Container(
          padding: EdgeInsets.only(top: 10, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quantity ${widget.quantity}', style: TextStyle(color: Colors.white70)),
              Text('From ${widget.from}', style: TextStyle(color: Colors.white70)),
              Text('To ${widget.to}', style: TextStyle(color: Colors.white70)),
              Text('Date ${widget.date}', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
