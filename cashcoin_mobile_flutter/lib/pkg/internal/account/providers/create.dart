import 'package:cashcoin_mobile_flutter/pkg/internal/account/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:cashcoin_mobile_flutter/pkg/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createProvider =
    StateNotifierProvider.autoDispose<CreateProvider, AsyncValue<bool>>(
        (_) => CreateProvider(const AsyncValue.data(false)));

class CreateProvider extends StateNotifier<AsyncValue<bool>> {
  final AccountApiInteractor _interactor = AccountApiInteractor();
  final Map<String, dynamic> _form = {
    'email': "",
    'phone': "",
    'password': "",
    'city': "",
    'estate': "",
    'street': "",
    'bnum': 0,
    'pc': "",
    'country': "",
    'name': "",
    'lname': "",
    'occupation': "",
    'terms': false,
  };

  CreateProvider(prop) : super(prop);

  setValue(String key, String? value) {
    _form[key] = value;
  }

  setTerms(bool t) {
    _form['terms'] = t;
  }

  bool _validateForm() {
    if ((_form.containsValue("") || _form.containsValue(null)) &&
        (_form['phone'] == "" || _form['phone'] != "")) {
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

  Future<void> _register(Map<String, dynamic> m) async {
    final Account a = Account(
      email: m['email'],
      phone: m['phone'],
      password: m['password'],
      address: Address(
        city: m['city'],
        estate: m['estate'],
        street: m['street'],
        buildingNumber: int.parse(m['bnum']),
        country: m['country'],
        postalCode: m['pc'],
      ),
      client: AClient(
          name: m['name'], lastName: m['lname'], occupation: m['occupation']),
    );
    await _interactor.register(a);
  }

  submit() async {
    try {
      state = const AsyncValue.loading();
      if(_form['terms'] == false) {
        throw Exception('accept the terms');
      }
      final bool ok = _validateForm();
      if (ok == false) {
        throw Exception('invalid field(s)');
      }
      await _register(_form);
      state = const AsyncData(true);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
