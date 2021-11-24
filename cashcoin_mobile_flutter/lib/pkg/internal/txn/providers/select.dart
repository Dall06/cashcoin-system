import 'package:cashcoin_mobile_flutter/pkg/internal/txn/model.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/usecase/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  all,
  withdraws,
  deposits,
}
final filterProvider = StateProvider.autoDispose((ref) => Filter.all);

final filteredListProvider = Provider.autoDispose<List<Transaction>>((ref) {
  final filter = ref.watch(filterProvider);
  final list = ref.watch(txnsProvider).value;
  if(list == null) {
    return [];
  }

  switch (filter) {
    case Filter.all:
      print('all');
      return list;
    case Filter.withdraws:
      print('w');
      return list.where((t) => t.type == "WITHDRAW").toList();
    case Filter.deposits:
      print('d');
      return list.where((t) => t.type == "DEPOSIT").toList();
  }
});

class StatsBinding {
  double withdraws = 0.0;
  double deposits  = 0.0;
  double savings = 0.0;
  int status = 0;
  double porcentage = 0.0;

  StatsBinding();

  setStatus() {
    savings = deposits - withdraws;

    if(savings < 0) {
      status = 5;
    } else if(savings == 0) {
      status = 0;
    } else if(savings < (deposits * 0.4)) {
      status = 1;
    } else if(savings < (deposits * 0.6)) {
      status = 2;
    } else if(savings < (deposits * 0.8)) {
      status = 3;
    } else if(savings == deposits) {
      status = 4;
    }

    porcentage = savings * 100 / deposits;

    if(porcentage < 0) {
      porcentage = 0;
    }
  }
}
final sBindingProvider = Provider.autoDispose((ref) {
  StatsBinding stats = StatsBinding();

  final data = ref.watch(txnsProvider).value;
  if(data == null) {
    return stats;
  }
  for (var element in data) {
    if (element.type == "DEPOSIT") {
      stats.deposits = element.amount!;
    } else if (element.type == "WITHDRAW") {
      stats.withdraws = element.amount!;
    }
  }
  stats.setStatus();
  return stats;
});

final txnsProvider = StateNotifierProvider.autoDispose<TxnsProvider,
    AsyncValue<List<Transaction>>>((_) => TxnsProvider());
class TxnsProvider extends StateNotifier<AsyncValue<List<Transaction>>> {
  final TxnApiInteractor _interactor = TxnApiInteractor();

  TxnsProvider() : super(const AsyncData([])) {
    select();
  }

  refresh() async {
    try {
      state = const AsyncValue.loading();
      final res = await _interactor.select();
      if (res.isEmpty) {
        throw Exception('no txns were found');
      }
      state = AsyncData(res);
    } catch (e) {
      state = AsyncError(e);
    }
  }

  select() async {
    try {
      state = const AsyncValue.loading();
      final res = await _interactor.select();
      if (res.isEmpty) {
        throw Exception('no txns were found');
      }
      state = AsyncData(res);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
