import 'package:cashcoin_mobile_flutter/pkg/internal/auth/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/auth/repository/api/repository.dart';

abstract class ApiRepository {
  Future<void> authenticate(Account account);
}

class AuthApiInteractor {
  final ApiRepository _authRepository = AuthApiRepository();

  AuthApiInteractor();

  Future<void> login(Account a) async {
    return await _authRepository.authenticate(a);
  }
}