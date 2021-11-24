import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorageService {
  final _storage = const FlutterSecureStorage();
  final _skey = 'session_string';

  saveSession(String ss) async {
    await _storage.write(key: _skey, value: ss);
  }

  Future<String?> returnSession() async {
    return await _storage.read(key: _skey);
  }

  clearSession() async {
    await _storage.delete(key: _skey);
  }
}