import 'package:cc_flutter_mobile/data/model/user.dart';

abstract class LoadStatus {
  const LoadStatus();
}

class InitialUserStatus extends LoadStatus {
  const InitialUserStatus();
}

class LoadingUserStatus extends LoadStatus {}

class LoadedUserStatus extends LoadStatus {
  final UserData user;

  LoadedUserStatus({this.user});
}

class FinishedStatus extends LoadStatus {}

class ErrorUserLoad extends LoadStatus {
  final Exception exception;

  ErrorUserLoad(this.exception);
}