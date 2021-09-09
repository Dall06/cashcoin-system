import 'package:cc_flutter_mobile/bloc/user/register/register_blocs.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/presentation/screens/home/widgets/signup_form_card.dart';
import 'package:cc_flutter_mobile/presentation/widgets/appbar_custom.dart';
import 'package:cc_flutter_mobile/presentation/widgets/cards/title_card.dart';
import 'package:flutter/material.dart';
// Config
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:cc_flutter_mobile/config/design_paddings.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
// BLOC
import 'package:cc_flutter_mobile/bloc/authentication/auth_blocs.dart';
// My packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cc_flutter_mobile/data/repositories/auth_repository.dart';
import 'package:cc_flutter_mobile/presentation/screens/home/widgets/login_form_card.dart';
import 'package:cc_flutter_mobile/presentation/screens/home/widgets/header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  double _preferredSize = 340;
  bool _isTitle = true;
  String _reaction = 'Smile';
  String _content = 'Log to the app or create your account';
  String _title = 'Hello Human!';

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              userRepository: context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Palette.blackBg,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_preferredSize),
            child: AppBarCustom(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: HeaderSection(),
                  ),
                  SizedBox(
                    height: space,
                  ),
                  Container(
                    height: 140,
                    child: TitleCard(
                      content: _content,
                      styleType: _reaction,
                      width: 50,
                      height: 50,
                      isTitle: _isTitle,
                      title: _title,
                    ),
                  ),
                  SizedBox(
                    height: space,
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: space,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.swipe,
                      color: Palette.lightGreen,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Hey! Swipe the card to navigate between sections',
                      style: TextStyle(
                        color: Palette.lightGreen,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: DesignPaddings.paddingL),
                  child: Theme(
                    data: ThemeData(
                      accentColor: Palette.lightGreen,
                    ),
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        if (index == 0) {
                          setState(() {
                            _isTitle = true;
                            _reaction = 'Smile';
                            _content = 'Log to the app or create your account';
                            _title = 'Hello Human!';
                          });
                        } else if (index == 1) {
                          setState(() {
                            _isTitle = false;
                            _reaction = 'Surprise';
                            _content =
                                'Fill the fields and sign up into CashCoin';
                            _title =
                                'Create an account,\nand become my new Friend!';
                          });
                        }
                      },
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            LoginFormCard(),
                          ],
                        ),
                        BlocListener<SignupBloc, SignupState>(
                          listener: (context, state) {
                            final _formStatus = state.formStatus;
                            if(_formStatus is SubmissionCreateSuccess) {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SignUpFormCard(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
