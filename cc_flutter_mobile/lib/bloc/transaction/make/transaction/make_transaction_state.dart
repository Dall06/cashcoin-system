import 'package:cc_flutter_mobile/bloc/transaction/make/submit_transaction.dart';

class MakeTransactionState {
  final double quantity;
  bool get isValidQuantity => quantity > 30.0;

  final int transactionType;

  final String destinationCode;
  bool get isValidCode => destinationCode.length > 0;

  final String concept;

  final String originCode;
  bool get isValidOriginCode => originCode.length > 0;

  final FormStatus formStatus;

  MakeTransactionState({
    this.quantity = 0.0,
    this.transactionType = 0,
    this.destinationCode = '',
    this.concept = '',
    this.originCode = '',
    this.formStatus = const InitialFormStatus(),
  });

  MakeTransactionState copyWith({
    double quantity,
    int transactionType,
    String destinationCode,
    String concept,
    String originCode,
    FormStatus formStatus,
  }) {
    return MakeTransactionState(
      quantity: quantity ?? this.quantity,
      transactionType: transactionType ?? this.transactionType,
      destinationCode: destinationCode ?? this.destinationCode,
      concept: concept ?? this.concept,
      originCode: originCode ?? this.originCode,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}