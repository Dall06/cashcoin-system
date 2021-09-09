import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class CCMeterCard extends StatefulWidget {
  final String opinion;

  CCMeterCard({@required this.opinion});

  _CCMeterCardState createState() => _CCMeterCardState();
}

class _CCMeterCardState extends State<CCMeterCard> {
  Map _returnedProps(String opinion) {
    if(opinion == 'empty') return {
        'id': 'empty',
        'title': 'Nothing to tell about you',
        'content':
        'You just have started, please deposit money\nto the account :)',
        'color': Palette.lightBlack,
        'icon': Icons.wb_twighlight,
        'iconColor': Colors.white70,
      };
    else if(opinion == 'really_bad') return {
      'id': 'really_bad',
      'title': 'Mister, your doing bad',
      'content': 'You should save money...',
      'color': Colors.black,
      'icon': Icons.warning,
      'IconColor': Palette.lightBlack,
    };
    else if(opinion == 'bad') return {
      'id': 'bad',
      'title': 'Nothing to tell about you',
      'content':
      'You just have started, please deposit money\nto the account :)',
      'color': Palette.lightBlack,
      'icon': Icons.wb_twighlight,
      'iconColor': Colors.white70,
    };
    else if(opinion == 'be_careful') return {
      'id': 'be_careful!',
      'title': 'Mister, be careful',
      'content': 'Please check you spends, you are\nstarting to lose savings',
      'color': Palette.yellowIdea,
      'icon': Icons.done,
      'iconColor': Palette.lightBlack,
    };
    else if(opinion == 'ok!') return {
      'id': 'ok!',
      'title': 'Everything ok!',
      'content': 'Continue like that  :)',
      'color': Palette.greenConfirm,
      'icon': Icons.thumb_up,
      'iconColor': Palette.lightBlack,
    };
    return {
      'id': 'empty',
      'title': 'Nothing to tell about you',
      'content':
      'You just have started, please deposit money\nto the account :)',
      'color': Palette.lightBlack,
      'icon': Icons.wb_twighlight,
      'iconColor': Colors.white70,
    };
  }

  @override
  Widget build(BuildContext context) {
    var _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = _height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Card(
      margin: EdgeInsets.only(bottom: 25),
      color: _returnedProps(widget.opinion)['color'],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Row(
          children: <Widget>[
            Icon(
              _returnedProps(widget.opinion)['icon'],
              size: 20,
              color: _returnedProps(widget.opinion)['iconColor'],
            ),
            SizedBox(
              height: space / 2,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _returnedProps(widget.opinion)['title'],
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: space / 2,
                  ),
                  Text(
                    _returnedProps(widget.opinion)['content'],
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
