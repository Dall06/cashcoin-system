import 'package:cc_flutter_mobile/bloc/transaction/load/load_status.dart';

class LoadTransactionsState {
  final LoadStatus loadStatus;

  LoadTransactionsState({this.loadStatus = const InitialStatus()});

  LoadTransactionsState copyWith({LoadStatus loadStatus}) {
    return LoadTransactionsState(
        loadStatus: loadStatus ?? this.loadStatus,
    );
  }
}