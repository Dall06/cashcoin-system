import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/location.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/usecase/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final makeTxnProvider = StateNotifierProvider.autoDispose<MakeTxnProvider, AsyncValue<bool>>((_) => MakeTxnProvider(const AsyncValue.data(false)));
class MakeTxnProvider extends StateNotifier<AsyncValue<bool>> {
  final TxnApiInteractor _interactor = TxnApiInteractor();
  final LocationService _location = LocationService();

  final Map<String, dynamic> _form = {
    'to': "",
    'amount': 0.0,
    'concept': "",
    'ref': "",
  };

  MakeTxnProvider(AsyncValue<bool> state) : super(state);

  setValue(String key, String? value) {
    _form[key] = value;
  }

  bool _validateForm() {
    if (_form.containsValue("0") ||_form.containsValue("") || _form.containsValue(null)) {
      return false;
    }
    return true;
  }



  Future<void> _make(Map<String, dynamic> m) async {
    Transaction txn = Transaction(
      amount: double.parse(m['amount']),
      concept: m['concept'],
      reference: m['ref'],
      location: TLocation(
        latitude: _location.lat,
        longitude: _location.lon,
        estate: _location.admArea,
        city: _location.locality,
        country: _location.country,
      ),
    );
    await _interactor.transfer(txn, m['to']);
  }

  submit() async {
    try {
      state = const AsyncValue.loading();

      final bool ok = _validateForm();
      if (ok == false) {
        throw Exception('invalid field(s)');
      }

      final got = await _location.getLocation();
      if(got == null) {
        throw Exception('something wrong wiht location');
      }

      await _make(_form);
     /**/
      state = const AsyncData(true);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}