import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdviceCard extends StatelessWidget {
  final String title;
  final String content;
  final double size;
  final double fSize1;
  final double fSize2;

  AdviceCard({
    @required this.title,
    @required this.content,
    @required this.size,
    @required this.fSize1,
    @required this.fSize2
  });

  void _launchURL() async => await canLaunch('https://cc-cashcoin.blogspot.com/')
      ? await launch('https://cc-cashcoin.blogspot.com/')
      : throw 'Could not launch https://cc-cashcoin.blogspot.com/';

  @override
  Widget build(BuildContext context) {
    var _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = _height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Card(
      margin: EdgeInsets.only(bottom: 25),
      color: Palette.lightBlack,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: _launchURL,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.lightbulb,
                size: this.size,
                color: Palette.yellowIdea,
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
                      title,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: this.fSize1,
                      ),
                    ),
                    SizedBox(
                      height: space / 2,
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        color: Palette.lightGreen,
                        fontSize: this.fSize2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
