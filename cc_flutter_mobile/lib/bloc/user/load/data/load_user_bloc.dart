import 'package:cc_flutter_mobile/bloc/user/load/load_user_blocs.dart';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cc_flutter_mobile/bloc/user/load/data/load_user_state.dart';
import 'package:cc_flutter_mobile/bloc/user/load/data/load_user_event.dart';
import 'package:cc_flutter_mobile/bloc/user/load/load_status.dart';

class LoadUserBloc extends Bloc<LoadUserEvent, LoadUserState> {
  final UserRepository userRepository;
  UserData _user;

  LoadUserBloc({this.userRepository}) : super(LoadUserState());

  @override
  Stream<LoadUserState> mapEventToState(LoadUserEvent event) async* {
    if (event is FetchUserStart) {
      try {
        yield state.copyWith(loadStatus: LoadingUserStatus());
        // yield
      } catch (e) {
        yield state.copyWith(loadStatus: ErrorUserLoad(e));
      }
    }
    else if (event is FetchUser) {
      try {
        _user = (await userRepository.findAccountByEmail());
        yield state.copyWith(loadStatus: LoadedUserStatus(user: _user));
        // yield
      } catch (e) {
        yield state.copyWith(loadStatus: ErrorUserLoad(e));
      }
    }
    else if (event is FetchFinished) {
      try {
        yield state.copyWith(loadStatus: FinishedStatus());
        // yield
      } catch (e) {
        yield state.copyWith(loadStatus: ErrorUserLoad(e));
      }
    }
  }
}