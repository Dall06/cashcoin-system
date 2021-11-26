import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/session.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Account _account = Account();

class AccountBinding {
  String name = "";
  String lad = "";
  String balance = "";
}
class DepositBinding {
  String code = "";
  String clabe = "";
}
final dBindingProvider = Provider.autoDispose((ref) {
  late DepositBinding binding = DepositBinding();
  final data = ref.watch(sessionProvider).value;
  if(data == null) {
    return binding;
  }
  binding.code = data.uuid!;
  binding.clabe = data.clabe!;
  return binding;
});

final aBindingProvider = Provider((ref) {
  late AccountBinding binding = AccountBinding();
  final data = ref.watch(sessionProvider).value;
  print('data');
  print(data);
  if(data == null) {
    return binding;
  }
  binding.balance = data.balance.toString();
  binding.name = data.client!.name! + " " + data.client!.lastName!;
  binding.lad = data.lad!;
  return binding;
});

final sessionProvider =
    StateNotifierProvider<SessionProvider, AsyncValue<Account>>(
        (_) => SessionProvider());

class SessionProvider extends StateNotifier<AsyncValue<Account>> {
  final AccountApiInteractor _interactor = AccountApiInteractor();
  final SessionStorageService _storageService = SessionStorageService();

  SessionProvider() : super(AsyncData(_account)) {
    select();
  }

  refresh() async {
    print('index1');
    try {
      state = const AsyncValue.loading();
      await _storageService.clearSession();
      final res = await _interactor.select();
      if (res.uuid == "" || res.uuid == null) {
        throw Exception('user not found');
      }
      print('refresh');
      print(res);
      state = AsyncData(res);
    } catch (e) {
      state = AsyncError(e);
    }
  }

  select() async {
    try {
      state = const AsyncValue.loading();
      final res = await _interactor.select();
      if (res.uuid == "" || res.uuid == null) {
        throw Exception('user not found');
      }
      state = AsyncData(res);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
