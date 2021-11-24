import 'package:cashcoin_mobile_flutter/pkg/internal/account/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/repository/api/repository.dart';

abstract class ApiRepository {
  Future<Account> index();
  Future<void> create(Account account);
  Future<void> changeStatus(String s);
  Future<void> changeAccount(String password, String email, String phone);
  Future<void> changePersonal(AClient c);
  Future<void> changePassword(String p, String np);
  Future<void> changeAddress(Account account);
}

class AccountApiInteractor {
  final ApiRepository _accountRepository = AccountApiRepository();

  AccountApiInteractor();

  Future<void> register(Account a) async {
    await _accountRepository.create(a);
    return;
  }

  Future<void> modifyStatus(String s) async {
    await _accountRepository.changeStatus(s);
    return;
  }

  Future<void> modifyAccount(String pass, String e, String p) async {
    await _accountRepository.changeAccount(pass, e, p);
    return;
  }

  Future<void> modifyPersonal(AClient c) async {
    await _accountRepository.changePersonal(c);
    return;
  }

  Future<void> modifyPassword(String p, String np) async {
    await _accountRepository.changePassword(p, np);
    return;
  }

  Future<void> modifyAddress(Account a) async {
    await _accountRepository.changeAddress(a);
    return;
  }

  Future<Account> select() async {
    return await _accountRepository.index();
  }
}