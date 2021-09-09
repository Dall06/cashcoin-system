import 'package:cc_flutter_mobile/bloc/user/load/load_user_blocs.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/presentation/widgets/alerts/close_account_alert.dart';
import 'package:cc_flutter_mobile/presentation/widgets/appbar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/design_paddings.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
// My packages
import 'package:cc_flutter_mobile/presentation/screens/settings/widgets/settings_app_card.dart';
import 'package:cc_flutter_mobile/presentation/screens/settings/widgets/settings_password_card.dart';
import 'package:cc_flutter_mobile/presentation/screens/settings/widgets/settings_security_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/buttons/custom_button.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/title_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/options_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return BlocProvider(
      create: (context) => LoadUserBloc(
        userRepository: context.read<UserRepository>(),
      ),
      child: Scaffold(
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
                    content: 'Check your settings and'
                        '\nmodify anything you need ;)',
                    title: 'Settings :o',
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
                    primaryText: 'Nothing to check?',
                    blueText: 'Tap me to go back',
                  ),
                ],
              ),
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: DesignPaddings.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SettingsEditCard(
                  name: 'Edit your information',
                  onTap: () => Navigator.of(context).pushNamed('edit')),
              SizedBox(
                height: 2 * space,
              ),
              SettingsSecurityCard(
                onTapPassword: () =>
                    Navigator.of(context).pushNamed('password'),
              ),
              SizedBox(
                height: space,
              ),
              SettingsAppCard(),
              SizedBox(
                height: 6 * space,
              ),
              CustomButton(
                  title: 'Log out',
                  onPressed: () async {
                    final storage = new FlutterSecureStorage();
                    await storage.deleteAll();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                  buttonType: 2),
              SizedBox(
                height: space,
              ),
              CustomButton(
                  title: 'Close account',
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => CloseAccountAlert(),),
                  buttonType: 1),
              SizedBox(
                height: 3 * space,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
