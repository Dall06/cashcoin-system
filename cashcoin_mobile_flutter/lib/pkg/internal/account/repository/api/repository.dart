import 'dart:convert';
import 'dart:io';

import 'package:cashcoin_mobile_flutter/config/paths.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/session.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/token.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/repository/api/request.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AccountApiRepository implements ApiRepository {
  final _jwt = JWTService();
  final _session = SessionStorageService();

  @override
  Future<Account> index() async {
    /*jsonDecode(response.body)*/
    try {
      final current = await _session.returnSession();
      if (current != null) {
        final sessionMap = jsonDecode(current) as Map<String, dynamic>;
        if (sessionMap.isNotEmpty) {
          return Account.fromMap(sessionMap);
        }
      }
      final tkn = await _jwt.returnTkn();

      if (tkn == "") {
        throw Exception("empty token");
      }

      final Map<String, dynamic> decodeTkn = JwtDecoder.decode(tkn!);
      final String uuid = decodeTkn['UUID'];
      //final req = authHelper.toReq(account);
      final uri = Uri.parse(apiRoute + "/account/$uuid");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final response = await get(uri, headers: headers);

      if (response.statusCode != 200) {
        throw Exception("server error");
      }
      await _session.saveSession(response.body);
      return Account.fromMap(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> create(Account account) async {
    try {
      final req = ReqCreate(
        email: account.email!,
        phone: account.phone,
        password: account.password!,
        city: account.address!.city!,
        estate: account.address!.estate!,
        street: account.address!.street!,
        buildingNumber: account.address!.buildingNumber!,
        country: account.address!.country!,
        postalCode: account.address!.postalCode!,
        name: account.client!.name!,
        lastName: account.client!.lastName!,
        occupation: account.client!.occupation!,
      ).toJson();

      final uri = Uri.parse(apiRoute + "/account/");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000"
      };

      final res = await post(uri, headers: headers, body: jsonEncode(req));
      if (res.statusCode != 200) {
        throw Exception('server' + res.statusCode.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> changeAccount(
      String pass, String email, String phone) async {
    try {
      final current = await _session.returnSession();
      final sessionMap = jsonDecode(current!) as Map<String, dynamic>;
      final tkn = await _jwt.returnTkn();

      if (tkn == "") {
        throw Exception("empty token");
      }

    if ((sessionMap['email'] == "" && sessionMap['phone'] == "")) {
      sessionMap['email'] = JwtDecoder.decode(tkn!)['email'];
      sessionMap['phone'] = JwtDecoder.decode(tkn)['phone'];
    }

      final req = ReqAccount(
        email: sessionMap['email'],
        phone: sessionMap['phone'],
        password: pass,
        newEmail: email,
        newPhone: phone,
      ).toJson();
      //final req = authHelper.toReq(account);
      final uri = Uri.parse(apiRoute + "/account/");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final res = await put(uri, headers: headers, body: jsonEncode(req));

      if (res.statusCode != 200) {
        throw Exception('server' + res.statusCode.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> changeAddress(Account account) async {
    try {
      final current = await _session.returnSession();
      final sessionMap = jsonDecode(current!) as Map<String, dynamic>;
      final tkn = await _jwt.returnTkn();
      String uuid = "";

      if (tkn == "") {
        throw Exception("empty token");
      }

      if (sessionMap['auuid'] == "") {
        throw Exception("empty session");
      }
      uuid = sessionMap['auuid'];

      final req = ReqAddress(
        uuid: uuid,
        city: account.address!.city!,
        estate: account.address!.estate!,
        street: account.address!.street!,
        buildingNumber: account.address!.buildingNumber!,
        country: account.address!.country!,
        postalCode: account.address!.postalCode!,
      ).toJson();
      print(req.toString());
      //final req = authHelper.toReq(account);
      final uri = Uri.parse(apiRoute + "/account/address");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final res = await put(uri, headers: headers, body: jsonEncode(req));

      if (res.statusCode != 200) {
        throw Exception('server' + res.statusCode.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> changePassword(String p, String np) async {
    try {
      final current = await _session.returnSession();
      final sessionMap = jsonDecode(current!) as Map<String, dynamic>;
      final tkn = await _jwt.returnTkn();

      if (tkn == "") {
        throw Exception("empty token");
      }

      final req = ReqPassword(
        email: sessionMap['email'],
        phone: sessionMap['phone'],
        password: p,
        newPassword: np,
      ).toJson();
      //final req = authHelper.toReq(account);
      final uri = Uri.parse(apiRoute + "/account/pass");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final res = await put(uri, headers: headers, body: jsonEncode(req));

      if (res.statusCode != 200) {
        throw Exception('server' + res.statusCode.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> changePersonal(AClient client) async {
    try {
      final current = await _session.returnSession();
      final sessionMap = jsonDecode(current!) as Map<String, dynamic>;
      final tkn = await _jwt.returnTkn();
      String uuid = "";

      if (tkn == "") {
        throw Exception("empty token");
      }

      if (sessionMap['auuid'] == "") {
        throw Exception("empty session");
      }
      uuid = sessionMap['auuid'];

      final req = ReqPersonal(
        uuid: uuid,
        name: client.name!,
        lastName: client.lastName!,
        occupation: client.occupation!,
      ).toJson();
      //final req = authHelper.toReq(account);
      final uri = Uri.parse(apiRoute + "/account/client");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final res = await put(uri, headers: headers, body: jsonEncode(req));

      if (res.statusCode != 200) {
        throw Exception('server' + res.statusCode.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> changeStatus(String s) async {
    try {
      final current = await _session.returnSession();
      if (current == null) {
        throw Exception("empty current");
      }
      final sessionMap = jsonDecode(current) as Map<String, dynamic>;
      final tkn = await _jwt.returnTkn();
      String uuid = "";

      if (sessionMap.isEmpty && current == "") {
        throw Exception("empty session");
      }

      if (tkn == "") {
        throw Exception("empty token");
      }

      if (sessionMap['auuid'] == "") {
        throw Exception("empty session");
      }
      uuid = sessionMap['auuid'];
      final req = ReqStatus(
        uuid: uuid,
        status: s,
      ).toJson();
      //final req = authHelper.toReq(account);
      final uri = Uri.parse(apiRoute+ "/account/status");
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Session-Token": "00000000",
        "Cookie": "auth_token=$tkn;"
      };
      final res = await put(uri, headers: headers, body: jsonEncode(req));

      if (res.statusCode != 200) {
        print('3');
        throw Exception('server' + res.statusCode.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
