import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cc_flutter_mobile/bloc/user/register/register_blocs.dart';
import 'package:cc_flutter_mobile/bloc/user/register/submit_status.dart';
import 'package:cc_flutter_mobile/bloc/user/register/signup/signup_state.dart';
import 'package:cc_flutter_mobile/bloc/user/register/signup/signup_event.dart';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;

  SignupBloc({this.userRepository}) : super(SignupState());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is EmailChanged) {
      yield state.copyWith(email: event.email);
    }
    else if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);
    }
    else if (event is PhoneChanged) {
      yield state.copyWith(phone: event.phone);
    }
    else if (event is NameChanged) {
      yield state.copyWith(name: event.name);
    }
    else if (event is LastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    }
    else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        UserData _userData = new UserData();
        UserAccount _userAccount = new UserAccount();
        print(state.lastName);
        _userData.name = state.name;
        _userData.lastName = state.lastName;

        _userAccount.phone = state.phone;
        _userAccount.password = state.password;
        _userAccount.email = state.email;

        _userData.userAccount = _userAccount;
        await userRepository.registerAccount(_userData);
        yield state.copyWith(formStatus: SubmissionCreateSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionCreateFailed(e));
      }
      yield state.copyWith(formStatus: InitialFormStatus());
    }
  }
}
