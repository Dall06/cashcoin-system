abstract class ChangePasswordEvent {}

class CurrentPasswordChanged extends ChangePasswordEvent {
  final String currentPassword;

  CurrentPasswordChanged({this.currentPassword});
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String newPassword;

  NewPasswordChanged({this.newPassword});
}

class ConfirmPasswordChanged extends ChangePasswordEvent {
  final String confirmPassword;

  ConfirmPasswordChanged({this.confirmPassword});
}

class ChangeSubmitted extends ChangePasswordEvent {}