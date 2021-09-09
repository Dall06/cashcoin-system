import 'package:cc_flutter_mobile/data/model/transaction.dart';
import 'package:cc_flutter_mobile/data/services/transaction_service.dart';

class TransactionRepository {
  Future<List<TransactionUser>> findUserTransactions(String code) async {
    final TransactionService transactionService = new TransactionService();
    List<TransactionUser> result = await transactionService.fetchUserTransactions(code);
    if(result == null || result == []) {
      return [];
    }
    print(result.length);
    return result;
  }

  Future<void> makeTransaction(TransactionDetail transactionDetail) async {
    final TransactionService transactionService = new TransactionService();
    bool result = await transactionService.makeTransaction(transactionDetail);
    if (result == false) {
      throw Exception('failed make transaction');
    }
  }
}
