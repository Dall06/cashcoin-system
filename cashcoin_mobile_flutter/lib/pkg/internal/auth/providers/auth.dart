import 'package:cashcoin_mobile_flutter/pkg/internal/auth/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/auth/usecase/api.dart';
import 'package:cashcoin_mobile_flutter/pkg/utils/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthBinding {
  String email = "";
  String phone = "";
  String password = "";
}

final authProvider =
    StateNotifierProvider.autoDispose<AuthProvider, AsyncValue<bool>>(
        (_) => AuthProvider(const AsyncValue.data(false)));

class AuthProvider extends StateNotifier<AsyncValue<bool>> {
  final AuthApiInteractor _apiInteractor = AuthApiInteractor();
  final AuthBinding _aBinding = AuthBinding();

  AuthProvider(prop) : super(prop);

  Future<void> _login() async {
    Account creds = Account(
      email: _aBinding.email,
      phone: _aBinding.phone,
      password: _aBinding.password,
    );
    await _apiInteractor.login(creds);
  }

  setUser(String? value) {
    if (Validator().isPhone(value)) {
      _aBinding.phone = value!;
    }
    _aBinding.email = value!;
  }

  setPassword(String? value) {
    _aBinding.password = value!;
  }

  bool _validateForm() {
    if (_aBinding.email == "" && _aBinding.phone == "") {
      return false;
    }
    if (_aBinding.password == "" ||
        !Validator().isPassword(_aBinding.password)) {
      return false;
    }
    return true;
  }

  Future<void> submit() async {
    try {
      state = const AsyncValue.loading();
      final bool ok = _validateForm();
      if (ok == false) {
        throw Exception('invalid credentials');
      }
      await _login();
      state = const AsyncValue.data(true);
    } catch (error) {
      state = AsyncValue.error(error);
    }
  }
}
