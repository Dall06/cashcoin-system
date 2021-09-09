import 'package:flutter/material.dart';
// My packages
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/logos_path.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:cc_flutter_mobile/presentation/widgets/logos/logo_cc.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LogoCCWidget(color: Palette.blackBg, image: Image(
            width: 80,
            height: 80,
            image: AssetImage(LogoPath.ccLogoPath),
          ),),
          Text(
            'Cash Coin',
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
