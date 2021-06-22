import 'dart:convert';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class AuthenticationService {
  Future<bool> logIn(UserAccount user) async {
    try {
      print(user.email);
      var response = await post(Uri.parse(
          ApiService.baseUrl + "/auth/login"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(user.toJson()));

      if(response.statusCode != 200) {
        return false;
      }
      String cookies = response.headers['set-cookie'];
      if (cookies != '') {
        String authToken = cookies.split('token=')[1];
        authToken = authToken.split(';')[0];
        final storage = new FlutterSecureStorage();
        await storage.write(key: 'set-token', value: authToken);
      }
      return true;
    } catch(error) {
      throw Exception(error);
    }
  }

  Future<Map> logOut() async {
    try {
      final response = await post(Uri.parse(ApiService.baseUrl + "/user"));
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }
}