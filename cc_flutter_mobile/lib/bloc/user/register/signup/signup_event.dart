abstract class SignupEvent {}

class EmailChanged extends SignupEvent {
  final String email;

  EmailChanged({this.email});
}

class PasswordChanged extends SignupEvent {
  final String password;

  PasswordChanged({this.password});
}

class PhoneChanged extends SignupEvent {
  final String phone;

  PhoneChanged({this.phone});
}

class NameChanged extends SignupEvent {
  final String name;

  NameChanged({this.name});
}

class LastNameChanged extends SignupEvent {
  final String lastName;

  LastNameChanged({this.lastName});
}

class SignUpSubmitted extends SignupEvent {}