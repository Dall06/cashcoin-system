import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/session.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/service/token.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/usecase/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exitProvider = StateNotifierProvider.autoDispose<ExitProvider, AsyncValue<bool>>((_) => ExitProvider(const AsyncValue.data(false)));
class ExitProvider extends StateNotifier<AsyncValue<bool>> {
  final SessionStorageService _storage = SessionStorageService();
  final JWTService _jwt = JWTService();
  final AccountApiInteractor _interactor = AccountApiInteractor();

  ExitProvider(AsyncValue<bool> state) : super(state);

  submit() async {
    try {
      state = const AsyncValue.loading();
      await _interactor.modifyStatus("LOGOUT");
      await _storage.clearSession();
      await _jwt.clearTkn();
      state = const AsyncData(true);
    } catch(e) {
      print(e);
      state = AsyncError(e);
    }
  }
}

final disableProvider = StateNotifierProvider.autoDispose<DisableProvider ,AsyncValue<bool>>((_) => DisableProvider(const AsyncValue.data(false)));
class DisableProvider extends StateNotifier<AsyncValue<bool>> {
  final SessionStorageService _storage = SessionStorageService();
  final JWTService _jwt = JWTService();
  final AccountApiInteractor _interactor = AccountApiInteractor();

  DisableProvider(AsyncValue<bool> state) : super(state);

  submit() async {
    try {
      await _interactor.modifyStatus("DISABLED");
      state = const AsyncValue.loading();
      await _storage.clearSession();
      await _jwt.clearTkn();
      state = const AsyncData(true);
    } catch(e) {
      state = AsyncError(e);
    }
  }
}