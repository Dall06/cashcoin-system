import 'package:cc_flutter_mobile/bloc/user/edit/password/change_password_bloc.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/presentation/widgets/appbar_custom.dart';
import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/design_paddings.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
// My packages
import 'package:cc_flutter_mobile/presentation/screens/password/widgets/password_from_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/title_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/options_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.blackBg,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(285),
          child: AppBarCustom(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TitleCard(
                  content: 'Modify your password\ntry to not lose it',
                  title: 'Change your password...',
                  styleType: 'Surprise',
                  width: 50,
                  height: 50,
                  isTitle: false,
                ),
                SizedBox(
                  height: space,
                ),
                OptionsCard(
                  onTap: () => Navigator.of(context).pop(),
                  blueText: 'If you do  not want to continue,',
                  primaryText: 'Tap me',
                ),
              ],
            ),
          )),
      body: BlocProvider(
        create: (context) => ChangePasswordBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: DesignPaddings.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PasswordFormCard(),
            ],
          ),
        ),
      ),
    );
  }
}
