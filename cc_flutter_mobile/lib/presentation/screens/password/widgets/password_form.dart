import 'package:cc_flutter_mobile/bloc/user/edit/password_blocs.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/presentation/widgets/buttons/custom_button.dart';
import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:cc_flutter_mobile/presentation/widgets/textfields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordForm extends StatefulWidget {
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _submitChangesButton() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(builder:
        (context, state) {
      return state.formStatus is FormSubmitting
          ? CustomProgressIndicator()
          : CustomButton(
          title: 'Confirm change',
          onPressed: () {
            if (_formKey.currentState.validate()) {
              context.read<ChangePasswordBloc>().add(ChangeSubmitted());
            }
          },
          buttonType: 4);
    });
  }

  Widget _currentPasswordField() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(builder:
        (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'current password',
          prefixIconData: Icons.lock,
          validator: (value) => state.isValidCurrentPass
              ? null
              : 'not valid password',
          onChanged: (value) => context.read<ChangePasswordBloc>().add(
            CurrentPasswordChanged(currentPassword: value),),
        ),
      );
    });
  }

  Widget _newPasswordField() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(builder:
        (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'new password',
          prefixIconData: Icons.lock,
          validator: (value) => state.isValidNewPass
              ? null
              : 'not valid password',
          onChanged: (value) => context.read<ChangePasswordBloc>().add(
            NewPasswordChanged(newPassword: value),),
        ),
      );
    });
  }

  Widget _confirmPasswordField() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(builder:
        (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'confirm password',
          prefixIconData: Icons.lock,
          validator: (value) => state.isValidConfirmPass
              ? null
              : 'not valid password',
          onChanged: (value) => context.read<ChangePasswordBloc>().add(
            ConfirmPasswordChanged(confirmPassword: value),),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
        if (formStatus is SubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Fill the information to authenticate',
              style: TextStyle(color: Colors.white54, fontSize: 16.0),
            ),
            SizedBox(
              height: 2 * space,
            ),
            _currentPasswordField(),
            SizedBox(
              height: space,
            ),
            _newPasswordField(),
            SizedBox(
              height: space,
            ),
            _confirmPasswordField(),
            SizedBox(
              height: space,
            ),
            SizedBox(
              height: 2 * space,
            ),
            _submitChangesButton(),
          ],
        ),
      ),
    );
  }
}