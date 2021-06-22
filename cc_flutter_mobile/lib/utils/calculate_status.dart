import 'package:cc_flutter_mobile/data/model/transaction.dart';

class CalculateStatus {
  Future<String> calculateStatusOpinion(List<TransactionUser> transactions, String code) async {
    print("func");
    num totalDeposits = 0;
    num totalTransactions = 0;

    transactions.forEach((transaction) {
      if(transaction.transactionUserType == 'Transfer'
          && transaction.transactionDetail.origin.code == code) {
        totalTransactions += transaction.transactionDetail.order.quantity;
      }
      if(transaction.transactionUserType == 'Deposit'
          && transaction.transactionDetail.destination.code == code) {
        totalDeposits += transaction.transactionDetail.order.quantity;
      }
    });

    print(totalTransactions);
    print(totalDeposits);

    if(totalDeposits < (totalTransactions*0.2)) {
      print("func1");
      return "really_bad";
    }
    else if(totalDeposits >= (totalTransactions*0.2) && totalDeposits < (totalTransactions*0.5)) {
      print("func2");
      return "bad";
    }
    else if(totalDeposits >= (totalTransactions*0.5) && totalDeposits < (totalTransactions*0.8)) {
      print("funcHere3");
      return "be_careful";
    }
    else if(totalDeposits >= (totalTransactions*0.8)) {
      print("func4");
      return "ok!";
    }
    print("func5");
    return "empty";
  }
}