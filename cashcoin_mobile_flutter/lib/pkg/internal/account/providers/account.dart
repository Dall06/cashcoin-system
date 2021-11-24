import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:cashcoin_mobile_flutter/pkg/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modifyAccountProvider =
    StateNotifierProvider.autoDispose<ModifyAccountProvider, AsyncValue<bool>>(
        (_) => ModifyAccountProvider(const AsyncValue.data(false)));

class ModifyAccountProvider extends StateNotifier<AsyncValue<bool>> {
  final AccountApiInteractor _interactor = AccountApiInteractor();
  final Map<String, String?> _form = {
    'email': "",
    'phone': "",
    'password': "",
  };

  ModifyAccountProvider(prop) : super(prop);

  setValue(String key, String? value) {
    _form[key] = value;
  }

  bool _validateForm() {
    if (_form.containsValue(null)) {
      return false;
    }
    if (!Validator().isEmail(_form['email'])) {
      return false;
    }
    if (!Validator().isPhone(_form['phone'])) {
      return false;
    }
    if (!Validator().isPassword(_form['password'])) {
      return false;
    }
    return true;
  }

  Future<void> _modifyAccount(Map<String, dynamic> m) async {
    String pass = m['password'];
    String e = m['email'];
    String p = m['phone'];
    await _interactor.modifyAccount(pass, e, p);
  }

  submit() async {
    try {
      state = const AsyncValue.loading();
      final bool ok = _validateForm();
      if (ok == false) {
        throw Exception('invalid field(s)');
      }
      await _modifyAccount(_form);
      state = const AsyncData(true);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
