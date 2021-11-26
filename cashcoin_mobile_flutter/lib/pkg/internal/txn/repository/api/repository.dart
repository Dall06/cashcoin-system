import 'dart:convert';
import 'dart:io';

import 'package:cashcoin_mobile_flutter/config/paths.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/session.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/token.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/repository/api/request.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/usecase/api.dart';
import 'package:http/http.dart';

class TxnApiRepository implements ApiRepository {
  final _jwt = JWTService();
  final _session = SessionStorageService();

  @override
  Future<List<Transaction>> index() async {
    try {
      final current = await _session.returnSession();
      final sessionMap = jsonDecode(current!) as Map<String, dynamic>;
      final tkn = await _jwt.returnTkn();
      List<Transaction> transactions = <Transaction>[];
      String uuid = "";

      if (tkn == "") {
        throw Exception("empty token");
      }

      if (sessionMap.isEmpty || sessionMap['auuid'] == "" ) {
        throw Exception("empty session");
      }
      uuid = sessionMap['auuid'];

      final uri = Uri.parse(apiRoute + "/txn/$uuid");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final response = await get(uri, headers: headers);
      if(response.body.isEmpty || jsonDecode(response.body) == null) {
        return transactions;
      }

      if (response.statusCode != 200) {
        throw Exception("server error " + response.statusCode.toString());
      }

      final resList = await jsonDecode(response.body) as List;
      for (var e in resList) {
        transactions.add(Transaction.fromMap(e));
      }

      return transactions;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> make(Transaction transaction, String toUUID) async {
    try {
      final current = await _session.returnSession();
      final sessionMap = jsonDecode(current!) as Map<String, dynamic>;
      final tkn = await _jwt.returnTkn();
      String uuid = "";

      if (tkn == "") {
        throw Exception("empty token");
      }

      if (sessionMap.isEmpty || sessionMap['auuid'] == "" ) {
        throw Exception("empty session");
      }
      uuid = sessionMap['auuid'];

      final req = ReqMake(
        auuid: uuid,
        reference: transaction.reference!,
        amount: transaction.amount!,
        longitude: transaction.location!.longitude!,
        country: transaction.location!.country!,
        latitude: transaction.location!.latitude!,
        concept: transaction.concept!,
        estate: transaction.location!.estate!,
        city: transaction.location!.city!,
        toUUID: toUUID,
      ).toJson();

      final uri = Uri.parse(apiRoute + "/txn/");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final res = await post(uri, headers: headers, body: jsonEncode(req));
      print(res.toString());
      if (res.statusCode != 200) {
        throw Exception('server' + res.statusCode.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
