import 'package:cc_flutter_mobile/data/model/transaction.dart';

abstract class LoadStatus {
  const LoadStatus();
}

class InitialStatus extends LoadStatus {
  const InitialStatus();
}

class LoadingStatus extends LoadStatus {}

class LoadedStatus extends LoadStatus {
  final List<TransactionUser> transactions;
  final String opinion;
  final String code;

  LoadedStatus({this.transactions, this.opinion, this.code});
}

class FinishedStatus extends LoadStatus {}

class ErrorLoad extends LoadStatus {
  final Exception exception;

  ErrorLoad(this.exception);
}