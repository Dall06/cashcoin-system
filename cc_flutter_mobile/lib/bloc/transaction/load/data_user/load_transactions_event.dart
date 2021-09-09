abstract class LoadTransactionsEvent {}

class FetchStart extends LoadTransactionsEvent {}

class FetchFinished extends LoadTransactionsEvent {}

class FetchTransactionsUser extends LoadTransactionsEvent {}
