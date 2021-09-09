import 'package:cc_flutter_mobile/bloc/user/load/load_status.dart';

class LoadUserState {
  final LoadStatus loadStatus;

  LoadUserState({this.loadStatus = const InitialUserStatus()});

  LoadUserState copyWith({LoadStatus loadStatus}) {
    return LoadUserState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }
}