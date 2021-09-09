import 'package:bloc/bloc.dart';
import 'package:cc_flutter_mobile/bloc/transaction/load/data_user/load_transactions_event.dart';
import 'package:cc_flutter_mobile/bloc/transaction/load/data_user/load_transactions_state.dart';
import 'package:cc_flutter_mobile/bloc/transaction/load/load_status.dart';
import 'package:cc_flutter_mobile/data/model/transaction.dart';
import 'package:cc_flutter_mobile/data/repositories/transaction_repository.dart';
import 'package:cc_flutter_mobile/utils/calculate_status.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoadTransactionsBloc
    extends Bloc<LoadTransactionsEvent, LoadTransactionsState> {
  final TransactionRepository transactionRepository;

  LoadTransactionsBloc({this.transactionRepository})
      : super(LoadTransactionsState());

  @override
  Stream<LoadTransactionsState> mapEventToState(
      LoadTransactionsEvent event) async* {
    if (event is FetchStart) {
      try {
        yield state.copyWith(loadStatus: LoadingStatus());
      } catch (e) {
        print(e);
        //Emit load_Status ErrorLoad
        yield state.copyWith(loadStatus: ErrorLoad(e));
      }
    } else if (event is FetchTransactionsUser) {
      try {
        final storage = new FlutterSecureStorage();
        String code = await storage.read(key: 'code');

        final List<TransactionUser> _transactions =
            (await transactionRepository.findUserTransactions(code));
        final String _opinion =
            (await CalculateStatus().calculateStatusOpinion(_transactions, code));
        yield state.copyWith(
            loadStatus:
                LoadedStatus(transactions: _transactions, opinion: _opinion, code: code));
      } catch (e) {
        print(e);
        //Emit load_Status ErrorLoad
        yield state.copyWith(loadStatus: ErrorLoad(e));
      }
    } else if (event is FetchFinished) {
      try {
        yield state.copyWith(loadStatus: FinishedStatus());
        // yield
      } catch (e) {
        print(e);
        yield state.copyWith(loadStatus: ErrorLoad(e));
      }
    }
  }
}
