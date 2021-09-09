import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/logos_path.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final String title;
  final String content;
  final String styleType;
  final double width;
  final double height;
  final bool isTitle;

  TitleCard({
    @required this.title,
    @required this.content,
    @required this.styleType,
    @required this.width,
    @required this.height,
    @required this.isTitle,
  });

  String get _validateEmotions {
    switch(this.styleType) {
      case 'Happy':
        return LogoPath.rHappyLogoPath;
      case 'Sad':
        return LogoPath.rSadDeadLogoPath;
      case 'Smile':
        return LogoPath.rSmileLogoPath;
      case 'Surprise':
        return LogoPath.rSurpriseMFLogoPath;
      case 'Love':
        return LogoPath.rILoveULogoPath;
      case 'Email':
        return LogoPath.rGotAnEmailLogoPath;
      case 'Mad':
        return LogoPath.rImReallyMadLogoPath;
      case 'Idea':
        return LogoPath.rIHaveAnIdeaLogoPath;
      default:
        return LogoPath.rHappyLogoPath;
    }
  }

  Color get _cardColor {
    if(this.isTitle) {
      return Palette.darkGreen;
    } else if(this.title == 'Account Created!') {
      return Palette.greenConfirm;
    } else if(this.title == 'Request Failed...') {
      return Palette.redWarning;
    }
    return Palette.lightBlack;
  }

  @override
  Widget build(BuildContext context) {
    var _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = _height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Card(
      color: _cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(_validateEmotions),
              width: this.width,
              height: this.height,
            ),
            SizedBox(height: space,),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: space,),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
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
