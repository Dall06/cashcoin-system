import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model.dart';

final modifyPersonalProvider =
    StateNotifierProvider.autoDispose<ModifyPersonalProvider, AsyncValue<bool>>(
        (_) => ModifyPersonalProvider(const AsyncValue.data(false)));

class ModifyPersonalProvider extends StateNotifier<AsyncValue<bool>> {
  final AccountApiInteractor _interactor = AccountApiInteractor();
  final Map<String, String?> _form = {
    'name': "",
    'lname': "",
    'occupation': "",
  };

  ModifyPersonalProvider(prop) : super(prop);

  setValue(String key, String? value) {
    _form[key] = value;
  }

  bool _validateForm() {
    if (_form.containsValue(null)) {
      return false;
    }
    return true;
  }

  Future<void> _modifyPersonal(Map<String, dynamic> m) async {
    final AClient c = AClient(
        name: m['name'], lastName: m['lname'], occupation: m['occupation']);
    await _interactor.modifyPersonal(c);
  }

  submit() async {
    try {
      state = const AsyncValue.loading();
      final bool ok = _validateForm();
      if (ok == false) {
        throw Exception('invalid field(s)');
      }
      await _modifyPersonal(_form);
      state = const AsyncData(true);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
