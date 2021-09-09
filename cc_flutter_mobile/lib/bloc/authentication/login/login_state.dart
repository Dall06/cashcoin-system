import 'package:cc_flutter_mobile/bloc/authentication/submit_status.dart';
import 'package:cc_flutter_mobile/config/extra_constants.dart';

class LoginState {
  final String email;
  bool get isValidEmail {
    final Pattern _pattern = ExtraConstants.emailRegexPattern;
    RegExp regExp = new RegExp(_pattern);
    if(!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  final String password;
  bool get isValidPassword{
    final Pattern _pattern = ExtraConstants.passwordRegexPattern;
    RegExp regExp = new RegExp(_pattern);
    if(!regExp.hasMatch(password)) {
      return false;
    }
    return true;
  }

  final FormStatus formStatus;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String email,
    String password,
    FormStatus formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
