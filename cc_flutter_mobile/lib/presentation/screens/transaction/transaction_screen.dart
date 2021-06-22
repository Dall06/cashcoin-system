import 'package:cc_flutter_mobile/bloc/transaction/make/make_transaction_blocs.dart';
import 'package:cc_flutter_mobile/bloc/user/load/load_user_blocs.dart';
import 'package:cc_flutter_mobile/data/repositories/transaction_repository.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/presentation/widgets/appbar_custom.dart';
import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/design_paddings.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
// My packages
import 'package:cc_flutter_mobile/presentation/screens/transaction/widgets/transaction_form_card.dart';
import 'package:cc_flutter_mobile/presentation/screens/transaction/widgets/transaction_status_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/title_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/options_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  Widget _buildStatusCard() {
    return BlocBuilder<LoadUserBloc, LoadUserState>(builder: (context, state) {
      final status = state.loadStatus;
      if (status is InitialUserStatus) {
        context.read<LoadUserBloc>().add(FetchUserStart());
      }
      if (status is LoadingUserStatus) {
        context.read<LoadUserBloc>().add(FetchUser());
      }
      if (status is LoadedUserStatus) {
        return TransactionStatusCard(
          quantity: status.user.balance,
        );
      }
      return Center(
        child: CustomProgressIndicator(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MakeTransactionBloc(
            transactionRepository: context.read<TransactionRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => LoadUserBloc(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.blackBg,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(345),
            child: AppBarCustom(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TitleCard(
                    content: 'Send money to anyone\nyou want',
                    title: 'Make a transaction *-*',
                    styleType: 'Surprise',
                    width: 50,
                    height: 50,
                    isTitle: false,
                  ),
                  SizedBox(height: space,),
                  _buildStatusCard(),
                  SizedBox(height: space,),
                  OptionsCard(
                    onTap: () => Navigator.of(context).pop(),
                    primaryText: 'Nothing to check?',
                    blueText: 'Tap me to go back',
                  ),
                ],
              )
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: DesignPaddings.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 2.5*space,),
              TransactionFormCard(),
            ],
          ),
        ),
      ),
    );
  }
}
