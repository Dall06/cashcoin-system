import 'package:cc_flutter_mobile/bloc/user/edit/data/edit_data_bloc.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/presentation/screens/edit/widgets/edit_form_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/appbar_custom.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/title_card.dart';
import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/design_paddings.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
// Packages
import 'package:cc_flutter_mobile/presentation/widgets/cards/options_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return BlocProvider(
      create: (context) => EditDataBloc(
        userRepository: context.read<UserRepository>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.blackBg,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(270),
            child: AppBarCustom(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TitleCard(
                    content: 'You can change it anytime\nyou want',
                    title: 'Modify your information',
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
                    primaryText: 'Nothing to change',
                    blueText: 'go back',
                  ),
                ],
              ),
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: DesignPaddings.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              EditFormCard(),
            ],
          ),
        ),
      ),
    );
  }
}
