import 'package:cc_flutter_mobile/bloc/authentication/submit_status.dart';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/repositories/auth_repository.dart';
import 'package:cc_flutter_mobile/bloc/authentication/login/login_event.dart';
import 'package:cc_flutter_mobile/bloc/authentication/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository userRepository;

  LoginBloc({this.userRepository}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is EmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        UserAccount _userToLog = new UserAccount();
        _userToLog.email = state.email;
        _userToLog.password = state.password;

        await userRepository.authenticateCredentials(_userToLog);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
      yield state.copyWith(formStatus: InitialFormStatus());
    }
  }
}
