import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/services/user_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  Future<UserData> findAccountByEmail() async {
    final UserService userService = new UserService();
    UserData result = await userService.fetchUserByEmail();
    if(result == null) {
      throw Exception('No user found');
    }
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'code');
    await storage.write(key: 'code', value: result.code);
    return result;
  }

  Future<void> registerAccount(UserData userData) async {
    final UserService userService = new UserService();
    bool result = await userService.addUser(userData);
    if (result == false) {
      throw Exception('failed log in');
    }
  }

  Future<void> editAccountData(UserData userData) async {
    print("repo update");
    final UserService userService = new UserService();
    bool result = await userService.updateUser(userData);
    if (result == false) {
      throw Exception('failed update');
    }
  }

  Future<void> changeAccountPassword(UserPassUpdate userPassUpdate) async {
    print("repo update");
    final UserService userService = new UserService();
    bool result = await userService.updateUserPassword(userPassUpdate);

    if (result == false) {
      throw Exception('failed log in');
    }
  }
}