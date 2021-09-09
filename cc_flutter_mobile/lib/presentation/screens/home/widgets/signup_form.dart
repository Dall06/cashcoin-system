import 'package:cc_flutter_mobile/bloc/user/register/register_blocs.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/presentation/widgets/buttons/custom_button.dart';
import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:cc_flutter_mobile/presentation/widgets/textfields/custom_text_field.dart';
import 'package:cc_flutter_mobile/presentation/widgets/textfields/tap_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_slider/page_slider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<PageSliderState> _slider = GlobalKey();
  bool pOneVisible = true;
  bool pTwoVisible = false;

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _signUpButton() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CustomProgressIndicator()
          : CustomButton(
              title: 'Sign Up',
              onPressed: () {
                print(state.password);
                if (_formKey.currentState.validate()) {
                  context.read<SignupBloc>().add(SignUpSubmitted());
                }
              },
              buttonType: 4);
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'email',
          prefixIconData: Icons.email,
          validator: (value) => state.isValidEmail ? null : 'invalid email',
          onChanged: (value) => context.read<SignupBloc>().add(
                EmailChanged(email: value),
              ),
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'password',
          prefixIconData: Icons.lock,
          validator: (value) =>
              state.isValidPassword ? null : 'invalid password',
          onChanged: (value) => context.read<SignupBloc>().add(
                PasswordChanged(password: value),
              ),
        ),
      );
    });
  }

  Widget _phoneField() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'phone',
          prefixIconData: Icons.phone,
          onChanged: (value) => context.read<SignupBloc>().add(
                PhoneChanged(phone: value),
              ),
        ),
      );
    });
  }

  Widget _nameField() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'name',
          prefixIconData: Icons.person,
          onChanged: (value) => context.read<SignupBloc>().add(
                NameChanged(name: value),
              ),
        ),
      );
    });
  }

  Widget _lastNameField() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'last name',
          prefixIconData: Icons.person,
          onChanged: (value) => context.read<SignupBloc>().add(
                LastNameChanged(lastName: value),
              ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionCreateFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
        if (formStatus is SubmissionCreateSuccess) {
          setState(() {
            _slider.currentState.previous();
            pOneVisible = true;
            pTwoVisible = false;
          });
          _showSnackBar(context, 'Account created!');
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Complete the information for your new account',
                style: TextStyle(color: Colors.white54, fontSize: 16.0),
              ),
              SizedBox(
                height: space,
              ),
              Container(
                height: 260,
                child: PageSlider(
                  key: _slider,
                  pages: <Widget>[
                    Visibility(
                      visible: pOneVisible,
                      maintainState: true,
                      child: Container(
                        child: Column(
                          children: [
                            _emailField(),
                            SizedBox(
                              height: space,
                            ),
                            _passwordField(),
                            SizedBox(
                              height: space,
                            ),
                            _phoneField(),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: pTwoVisible,
                      maintainState: true,
                      child: Container(
                        child: Column(
                          children: [
                            _nameField(),
                            SizedBox(
                              height: space,
                            ),
                            _lastNameField(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: space,),
              Container(
                height: 35,
                child: TapInkWell(
                  label: 'Tap to check your account information',
                  onTap: () {
                    if(pOneVisible == true) {
                      print('hi true');
                      _slider.currentState.next();
                      setState(() {
                        pOneVisible = false;
                        pTwoVisible = true;
                      });
                    }
                    else if(pTwoVisible == true) {
                      print('hi false');
                      _slider.currentState.previous();
                      setState(() {
                        pOneVisible = true;
                        pTwoVisible = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 2*space,),
              _signUpButton(),
            ],
          )),
    );
  }
}
