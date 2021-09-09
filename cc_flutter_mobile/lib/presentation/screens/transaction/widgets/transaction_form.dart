import 'package:cc_flutter_mobile/bloc/transaction/make/make_transaction_blocs.dart';
import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:cc_flutter_mobile/presentation/widgets/buttons/custom_button.dart';
import 'package:cc_flutter_mobile/presentation/widgets/custom_progress_indicator.dart';
import 'package:cc_flutter_mobile/presentation/widgets/textfields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isBankAccount = false;
  String _accountTypeText = 'account Code';

  void _throwError(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _makeTransactionButton() {
    return BlocBuilder<MakeTransactionBloc, MakeTransactionState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CustomProgressIndicator()
          : CustomButton(
              title: 'Complete transaction',
              onPressed: () {
                context.read<MakeTransactionBloc>().add(
                  OriginCodeChanged(code: 'hardcoded'),);
                context.read<MakeTransactionBloc>().add(
                  TransactionTypeIDChanged(transactionType: 1),);

                if (_formKey.currentState.validate()) {
                  context
                      .read<MakeTransactionBloc>()
                      .add(TransactionSubmitted());
                }
              },
              buttonType: 4);
    });
  }

  Widget _quantityField() {
    return BlocBuilder<MakeTransactionBloc, MakeTransactionState>(
        builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'quantity',
          prefixIconData: Icons.money,
          keyBoardType: TextInputType.number,
          validator: (value) =>
          state.isValidQuantity ? null : 'invalid quantity, it must be up to 30 mxn',
          onChanged: (value) => context.read<MakeTransactionBloc>().add(
            QuantityChanged(quantity: double.parse(value)),),
        ),
      );
    });
  }

  Widget _destinationCodeField() {
    return BlocBuilder<MakeTransactionBloc, MakeTransactionState>(
        builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'destination',
          prefixIconData: Icons.code,
          validator: (value) =>
          state.isValidCode ? null : 'invalid code',
          onChanged: (value) => context.read<MakeTransactionBloc>().add(
            DestinationCodeChanged(code: value),),
        ),
      );
    });
  }

  Widget _conceptField() {
    return BlocBuilder<MakeTransactionBloc, MakeTransactionState>(
        builder: (context, state) {
      return Material(
        elevation: 8,
        color: Colors.transparent,
        child: CustomTextField(
          label: 'concept',
          prefixIconData: Icons.description,
          onChanged: (value) => context.read<MakeTransactionBloc>().add(
                ConceptChanged(concept: value),
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

    return BlocListener<MakeTransactionBloc, MakeTransactionState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _throwError(context, formStatus.exception.toString());
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
                'Fill the information to make a transaction',
                style: TextStyle(color: Colors.white54, fontSize: 16.0),
              ),
              SizedBox(
                height: space,
              ),
              SwitchListTile(
                activeColor: Palette.lightGreen,
                inactiveThumbColor: Palette.darkGreen,
                value: _isBankAccount,
                title: Text(
                  _accountTypeText,
                  style: TextStyle(color: Colors.white),
                ),
                onChanged: (_) => _throwError(context, 'Not implemented'),
              ),
              SizedBox(
                height: space,
              ),
              _quantityField(),
              SizedBox(
                height: space,
              ),
              _destinationCodeField(),
              SizedBox(
                height: space,
              ),
              _conceptField(),
              SizedBox(
                height: 2 * space,
              ),
              _makeTransactionButton(),
            ],
          )),
    );
  }
}
