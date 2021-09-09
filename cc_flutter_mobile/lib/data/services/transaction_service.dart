import 'dart:convert';
import 'package:cc_flutter_mobile/data/model/transaction.dart';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'api_service.dart';

class TransactionService {
  Future<List<TransactionUser>> fetchUserTransactions(String code) async {
    try {
      List<TransactionUser> transactions = <TransactionUser>[];

      final response = await get(
          Uri.parse(ApiService.baseUrl + "/transaction/find_user_t/$code"),
          headers: {
            "Content-Type": "application/json",
          });

      if(response.statusCode != 200) {
        throw Exception('invalid request');
      }

      List<dynamic> responseJson = await json.decode(response.body) as List<dynamic>;
      responseJson.forEach((e) {
        transactions.add(TransactionUser.fromJson(e));
      });
      return transactions;
    } catch (e) {
      return null;
    }
  }

  Future<bool> makeTransaction(TransactionDetail transactionDetail) async {
    try {
      final storage = new FlutterSecureStorage();
      String currentToken = await storage.read(key: 'set-token');

      final response = await post(
          Uri.parse(ApiService.baseUrl + "/transaction/make_t",),
          headers: {
            "Content-Type": "application/json",
            "Cookie": "token=$currentToken;"
          },
          body: jsonEncode(transactionDetail.toJson()));
      if(response.statusCode != 200) {
        return null;
      }
      return true;
    } catch (e) {
      return null;
    }
  }
}
