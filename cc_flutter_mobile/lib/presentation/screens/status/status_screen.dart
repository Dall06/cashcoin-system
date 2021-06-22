import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
// My packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cc_flutter_mobile/bloc/transaction/load/load_transactionuser_blocs.dart';
import 'package:cc_flutter_mobile/bloc/user/load/load_user_blocs.dart';
import 'package:cc_flutter_mobile/data/model/transaction.dart';
import 'package:cc_flutter_mobile/data/repositories/transaction_repository.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/presentation/screens/status/widgets/list_view.dart';
import 'package:cc_flutter_mobile/presentation/screens/status/widgets/action_card.dart';
import 'package:cc_flutter_mobile/presentation/screens/status/widgets/advice_card.dart';
import 'package:cc_flutter_mobile/presentation/screens/status/widgets/ccmeter_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/appbar_custom.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/title_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/status_card.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final List<Map<String, dynamic>> _possibleActions = [
    {
      'title': 'Deposit',
      'content': 'Add money to your account',
      'action': 'deposit',
      'icon': Icons.wallet_giftcard
    },
    {
      'title': 'Transfer',
      'content': 'Send money to a friend, or to me :)',
      'action': 'transaction',
      'icon': Icons.add_box_rounded
    },
    {
      'title': 'Settings',
      'content': 'Modify app and account parameters',
      'action': 'settings',
      'icon': Icons.settings
    },
  ];
  List<TransactionUser> transactionsList = [];

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoadTransactionsBloc(
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
          body: Stack(
            children: <Widget>[
              Container(
                height: height - 400,
                child: BlocBuilder<LoadUserBloc, LoadUserState>(
                  builder: (context, state) {
                    final status = state.loadStatus;
                    if (status is InitialUserStatus) {
                      context.read<LoadUserBloc>().add(FetchUserStart());
                    }
                    if (status is LoadingUserStatus) {
                      context.read<LoadUserBloc>().add(FetchUser());
                    }
                    if (status is LoadedUserStatus) {
                      return AppBarCustom(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TitleCard(
                                content: status.user.name,
                                title: 'Welcome Back <3\nI missed you',
                                width: 55,
                                height: 55,
                                styleType: 'Love',
                                isTitle: false,
                              ),
                              SizedBox(
                                height: space,
                              ),
                              StatusCard(
                                quantity: status.user.balance,
                                email: status.user.userAccount.email,
                                onPressed: () {
                                  context
                                      .read<LoadUserBloc>()
                                      .add(FetchUserStart());
                                  context
                                      .read<LoadTransactionsBloc>()
                                      .add(FetchStart());
                                },
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Container(
                                height: 130,
                                child: Theme(
                                  data:
                                      ThemeData(accentColor: Palette.darkGreen),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: _possibleActions.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: ActionCard(
                                          title: _possibleActions[index]
                                              ['title'],
                                          content: _possibleActions[index]
                                              ['content'],
                                          actionType: _possibleActions[index]
                                              ['action'],
                                          icon: _possibleActions[index]['icon'],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CustomProgressIndicator(),
                    );
                  },
                ),
              ),
              SlidingUpPanel(
                color: Palette.blackBg,
                minHeight: height - 520,
                maxHeight: height - 120,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                header: Container(
                  margin: EdgeInsets.fromLTRB(50, 20, 50, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_circle_up, color: Palette.lightGreen,),
                      SizedBox(width: 10,),
                      Text(
                        'Pull me up to check all of your transactions',
                        style: TextStyle(color: Palette.lightGreen,),)
                    ],
                  ),
                ),
                panel: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: BlocBuilder<LoadTransactionsBloc, LoadTransactionsState>(
                    builder: (context, state) {
                      final status = state.loadStatus;
                      if (status is InitialStatus) {
                        context.read<LoadTransactionsBloc>().add(FetchStart());
                      }
                      if (status is LoadingStatus) {
                        context
                            .read<LoadTransactionsBloc>()
                            .add(FetchTransactionsUser());
                      }
                      if (status is LoadedStatus) {
                        transactionsList = status.transactions;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 125,
                              child: CCMeterCard(
                                opinion: status.opinion,
                              ),
                            ),
                            AdviceCard(
                              title: 'Having troubles saving money?',
                              content: 'Visit our blog and learn!',
                              size: 35,
                              fSize1: 16,
                              fSize2: 14,
                            ),
                            SizedBox(
                              height: space,
                            ),
                            ListViewTransactions(
                              transactions: status.transactions,
                              code: status.code,
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: CustomProgressIndicator(),
                      );
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
