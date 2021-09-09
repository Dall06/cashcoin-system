import 'package:cc_flutter_mobile/bloc/authentication/auth_blocs.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/presentation/widgets/buttons/custom_button.dart';
import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:cc_flutter_mobile/presentation/widgets/textfields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CustomProgressIndicator()
          : CustomButton(
          title: 'Log In',
          onPressed: () {
            if (_formKey.currentState.validate()) {
              context.read<LoginBloc>().add(LoginSubmitted());
            }
          },
          buttonType: 4);
    });
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          validator: (value) =>
              state.isValidEmail ? null : 'not valid email',
          onChanged: (value) => context.read<LoginBloc>().add(
            EmailChanged(email: value),),
          label: 'email',
          prefixIconData: Icons.email,
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'password',
          validator: (value) => state.isValidPassword
              ? null
              : 'not valid password',
          onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(
              password: value),),
          prefixIconData: Icons.lock,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
        if(formStatus is SubmissionSuccess) {
          Navigator.of(context).popAndPushNamed('status');
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Fill the information to authenticate',
              style: TextStyle(color: Colors.white54, fontSize: 16.0),),
            SizedBox(height: 2 * space,),
            _emailField(),
            SizedBox(height: space,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _passwordField(),
                SizedBox(height: space,),
                InkWell(
                  splashColor: Colors.transparent,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.white70),),
                  onTap: null,),
              ],
            ),
            SizedBox(height: 2 * space,),
            _loginButton(),
          ],
        ),
      ),
    );
  }
}
