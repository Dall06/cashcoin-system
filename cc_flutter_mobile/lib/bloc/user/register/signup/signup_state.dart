import 'package:cc_flutter_mobile/bloc/user/register/submit_status.dart';
import 'package:cc_flutter_mobile/config/extra_constants.dart';

class SignupState {
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

  final String name;

  final String lastName;

  final String phone;

  final FormStatus formStatus;

  SignupState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.lastName = '',
    this.phone = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignupState copyWith({
    String email,
    String password,
    String name,
    String lastName,
    String phone,
    FormStatus formStatus,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
