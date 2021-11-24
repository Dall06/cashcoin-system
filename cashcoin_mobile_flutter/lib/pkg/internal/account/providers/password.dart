import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:cashcoin_mobile_flutter/pkg/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modifyPasswordProvider =
    StateNotifierProvider.autoDispose<ModifyPasswordProvider, AsyncValue<bool>>(
        (_) => ModifyPasswordProvider(const AsyncValue.data(false)));

class ModifyPasswordProvider extends StateNotifier<AsyncValue<bool>> {
  final AccountApiInteractor _interactor = AccountApiInteractor();
  final Map<String, String?> _form = {
    'password': "",
    'confirm': "",
    'newPassword': "",
  };

  ModifyPasswordProvider(prop) : super(prop);

  setValue(String key, String? value) {
    _form[key] = value;
  }

  bool _validateForm() {
    if (_form.containsValue("") || _form.containsValue(null)) {
      return false;
    }
    if (!Validator().isPassword(_form['password']) ||
        !Validator().isPassword(_form['confirm']) ||
        !Validator().isPassword(_form['newPassword'])) {
      return false;
    }
    if (_form['confirm'] != _form['newPassword']) {
      return false;
    }
    return true;
  }

  Future<void> _modifyPassword(Map<String, dynamic> m) async {
    await _interactor.modifyPassword(m['password'], m['newPassword']);
  }

  submit() async {
    try {
      state = const AsyncValue.loading();
      final bool ok = _validateForm();
      if (ok == false) {
        state = const AsyncError('invalid field(s)');
        return;
      }
      await _modifyPassword(_form);
      state = const AsyncData(true);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
