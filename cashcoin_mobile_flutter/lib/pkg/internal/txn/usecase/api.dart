import 'package:cashcoin_mobile_flutter/pkg/internal/txn/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/repository/api/repository.dart';

abstract class ApiRepository {
  Future<void> make(Transaction transaction, String to);
  Future<List<Transaction>> index();
}

class TxnApiInteractor {
  final ApiRepository _repository = TxnApiRepository();

  Future<void> transfer(Transaction transaction, String to) async {
    await _repository.make(transaction, to);
    return;
  }

  Future<List<Transaction>> select() async {
    return await _repository.index();
  }
}