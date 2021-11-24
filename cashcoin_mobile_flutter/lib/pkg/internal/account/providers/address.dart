import 'package:cashcoin_mobile_flutter/pkg/internal/account/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modifyAddressProvider =
StateNotifierProvider.autoDispose<ModifyAddressProvider, AsyncValue<bool>>(
        (_) => ModifyAddressProvider(const AsyncValue.data(false)));

class ModifyAddressProvider extends StateNotifier<AsyncValue<bool>> {
  final AccountApiInteractor _interactor = AccountApiInteractor();
  final Map<String, String?> _form = {
    'city': "",
    'estate': "",
    'street': "",
    'bnum': "",
    'pc': "",
    'country': "",
  };

  ModifyAddressProvider(prop) : super(prop);

  setValue(String key, String? value) {
    _form[key] = value;
  }

  Future<void> _register(Map<String, dynamic> m) async {
    final Account a = Account(
      address: Address(
        city: m['city'],
        estate: m['estate'],
        street: m['street'],
        buildingNumber: (m['bnum'] != "") ? int.parse(m['bnum']) : 0,
        country: m['country'],
        postalCode: m['pc'],
      ),
    );
    await _interactor.modifyAddress(a);
  }

  submit() async {
    try {
      state = const AsyncValue.loading();
      await _register(_form);
      state = const AsyncData(true);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
