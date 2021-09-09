import 'dart:convert' show jsonDecode, jsonEncode;
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserService {
  Future<dynamic> fetchUserByEmail() async {
    try {
      final storage = new FlutterSecureStorage();
      String currentToken = await storage.read(key: 'set-token');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(currentToken);
      String email = decodedToken['email'];

      final response = await get(
          Uri.parse(ApiService.baseUrl + "/user/find/$email"),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode != 200) {
        throw Exception('invalid request');
      }
      return UserData.fromJson(jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }

  Future<bool> addUser(UserData user) async {
    try {
      final response = await post(Uri.parse(ApiService.baseUrl + "/user/save"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user.toJson()));
      if (response.statusCode != 200) {
        return null;
      }
      return true;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> updateUser(UserData user) async {
    try {
      final storage = new FlutterSecureStorage();
      String currentToken = await storage.read(key: 'set-token');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(currentToken);
      String email = decodedToken['email'];

      final response = await put(
          Uri.parse(ApiService.baseUrl + "/user/edit/$email"),
          headers: {
            "Content-Type": "application/json",
            "Cookie": "token=$currentToken;"
          },
          body: jsonEncode(user.toJson()));
      if (response.statusCode != 200) {
        print(response.statusCode);
        return false;
      }
      return true;
    } catch (error) {
      print("service update err");
      print(error);
      throw Exception(error);
    }
  }

  Future<bool> updateUserPassword(UserPassUpdate user) async {
    try {
      final storage = new FlutterSecureStorage();
      String currentToken = await storage.read(key: 'set-token');

      final response = await put(
          Uri.parse(ApiService.baseUrl + "/user/edit"),
          headers: {
            "Content-Type": "application/json",
            "Cookie": "token=$currentToken;"
          },
          body: jsonEncode(user.toJson()));
      if (response.statusCode != 200) {
        print(response.body);
        return false;
      }
      return true;
    } catch (error) {
      throw Exception(error);
    }
  }
}
