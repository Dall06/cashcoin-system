import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/services/authentication_service.dart';

class AuthenticationRepository {
  Future<void> authenticateCredentials(UserAccount user) async {
    final AuthenticationService authenticationService = new AuthenticationService();
    bool result = await authenticationService.logIn(user);
    if (result == false) {
      throw Exception('failed log in');
    }
  }
}