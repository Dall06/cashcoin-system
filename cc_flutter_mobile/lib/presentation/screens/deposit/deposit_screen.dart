import 'package:cc_flutter_mobile/bloc/user/load/load_user_blocs.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/presentation/widgets/appbar_custom.dart';
import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/design_paddings.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
// My packages
import 'package:cc_flutter_mobile/presentation/screens/deposit/widgets/deposit_card.dart';
import 'package:cc_flutter_mobile/presentation/screens/deposit/widgets/qrcode_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/title_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/options_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepositScreen extends StatelessWidget {
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
            preferredSize: Size.fromHeight(295),
            child: AppBarCustom(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TitleCard(
                    content: 'Check your info and'
                        '\nshare to your contact'
                        '\nto get money',
                    title: 'Deposit information :D',
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
        body: BlocBuilder<LoadUserBloc, LoadUserState>(
          builder: (context, state) {
            final status = state.loadStatus;
            if (status is InitialUserStatus) {
              context.read<LoadUserBloc>().add(FetchUserStart());
            }
            if (status is LoadingUserStatus) {
              context.read<LoadUserBloc>().add(FetchUser());
            }
            if (status is LoadedUserStatus) {
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: DesignPaddings.paddingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DepositCard(
                      name: status.user.name,
                      email: status.user.userAccount.email,
                      code: status.user.code,
                    ),
                    SizedBox(
                      height: 2 * space,
                    ),
                    QRCodeCard(
                      stringToQR: status.user.code,
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CustomProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
