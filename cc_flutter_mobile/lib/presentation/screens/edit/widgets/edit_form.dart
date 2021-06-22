import 'package:cc_flutter_mobile/bloc/user/edit/data_blocs.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/presentation/widgets/buttons/custom_button.dart';
import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:cc_flutter_mobile/presentation/widgets/textfields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditForm extends StatefulWidget {
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _submitChangesButton() {
    return BlocBuilder<EditDataBloc, EditDataState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CustomProgressIndicator()
          : CustomButton(
          title: 'Confirm Changes',
          onPressed: () {
            if (_formKey.currentState.validate()) {
              context.read<EditDataBloc>().add(ChangeSubmitted());
            }
          },
          buttonType: 4);
    });
  }

  Widget _emailField() {
    return BlocBuilder<EditDataBloc, EditDataState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'email',
          prefixIconData: Icons.email,
          initialValue: state.email,
          onChanged: (value) => context.read<EditDataBloc>().add(
            EmailChanged(email: value),),
        ),
      );
    });
  }

  Widget _phoneField() {
    return BlocBuilder<EditDataBloc, EditDataState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'phone',
          prefixIconData: Icons.phone,
          initialValue: state.email,
          onChanged: (value) => context.read<EditDataBloc>().add(
            PhoneChanged(phone: value),),
        ),
      );
    });
  }

  Widget _nameField() {
    return BlocBuilder<EditDataBloc, EditDataState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'name',
          prefixIconData: Icons.person,
          initialValue: state.name,
          onChanged: (value) => context.read<EditDataBloc>().add(
            NameChanged(name: value),
          ),
        ),
      );
    });
  }

  Widget _lastNameField() {
    return BlocBuilder<EditDataBloc, EditDataState>(builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'last name',
          prefixIconData: Icons.person,
          initialValue: state.lastName,
          onChanged: (value) => context.read<EditDataBloc>().add(
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

    return BlocListener<EditDataBloc, EditDataState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
        if(formStatus is SubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Fill the information that you want to Change',
              style: TextStyle(color: Colors.white54, fontSize: 16.0),
            ),
            SizedBox(
              height: 2 * space,
            ),
            _emailField(),
            SizedBox(
              height: space,
            ),
            _phoneField(),
            SizedBox(
              height: space,
            ),
            _nameField(),
            SizedBox(
              height: space,
            ),
            _lastNameField(),
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