import 'dart:convert';
import 'dart:io';

import 'package:cashcoin_mobile_flutter/config/paths.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/session.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/token.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/auth/usecase/api.dart';
import 'package:http/http.dart';

import 'request.dart';

class AuthApiRepository implements ApiRepository {
  final _jwt = JWTService();
  final _session = SessionStorageService();

  @override
  Future<void> authenticate(account) async {
    try {
      final req = ReqAuth(email: account.email!,
          phone: account.phone,
          password: account.password!).toJson();

      var response = await post(Uri.parse(
          apiRoute + "/auth/"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "X-Session-Token": "00000000"
          },
          body: jsonEncode(req));

      // if response status not ok
      if(response.statusCode != 200) {
        throw Exception('server error');
      }
      // if cookie token empty
      String? cookies = response.headers['set-cookie'];
      if (cookies == '') {
        throw Exception('empty token');
      }
      await _jwt.saveTkn(cookies!);
      await _session.saveSession(response.body);
    } catch(e) {
      throw Exception(e);
    }
  }
}

