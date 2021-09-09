abstract class MakeTransactionEvent {}

class QuantityChanged extends MakeTransactionEvent {
  final double quantity;

  QuantityChanged({this.quantity});
}

class TransactionTypeIDChanged extends MakeTransactionEvent {
  final int transactionType;

  TransactionTypeIDChanged({this.transactionType});
}

class DestinationCodeChanged extends MakeTransactionEvent {
  final String code;

  DestinationCodeChanged({this.code});
}

class ConceptChanged extends MakeTransactionEvent {
  final String concept;

  ConceptChanged({this.concept});
}

class OriginCodeChanged extends MakeTransactionEvent {
  final String code;

  OriginCodeChanged({this.code});
}

class TransactionSubmitted extends MakeTransactionEvent {}
