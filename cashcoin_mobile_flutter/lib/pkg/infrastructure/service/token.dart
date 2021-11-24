import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JWTService {
  final _storage = const FlutterSecureStorage();

  saveTkn(String tkn) async {
    tkn = tkn.replaceAll('auth_token=', '');
    await _storage.write(key: 'auth_token', value: tkn);
  }

  Future<String?> returnTkn() async {
    return await _storage.read(key: 'auth_token');
  }

  clearTkn() async {
    await _storage.delete(key: 'auth_token');
  }
}

/*
import 'package:cashcoin_mobile_flutter/pkg/utils/split.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

class Token {
  bool saveAuthToken(Response response) {
    String? cookies = response.headers['set-cookie'];
    if (cookies == '') {
      return false;
    }
    String authToken = SplitString().TokenString(cookies!);
    Hive.box('session').put('auth_token', authToken);
    return true;
  }

  String getToken() {
    return Hive.box('session').get('auth_token');
  }
}*/
