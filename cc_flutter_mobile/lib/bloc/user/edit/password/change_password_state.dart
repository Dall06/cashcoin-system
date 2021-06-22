import 'package:cc_flutter_mobile/bloc/user/edit/submit_password.dart';
import 'package:cc_flutter_mobile/config/extra_constants.dart';

class ChangePasswordState {
  final String currentPassword;
  bool get isValidCurrentPass {
    final Pattern _pattern = ExtraConstants.passwordRegexPattern;
    RegExp regExp = new RegExp(_pattern);
    if(!regExp.hasMatch(currentPassword)) {
      return false;
    }
    return true;
  }

  final String newPassword;
  bool get isValidNewPass {
    final Pattern _pattern = ExtraConstants.passwordRegexPattern;
    RegExp regExp = new RegExp(_pattern);
    if(!regExp.hasMatch(newPassword)) {
      return false;
    }
    return true;
  }

  final String confirmPassword;
  bool get isValidConfirmPass {
    final Pattern _pattern = ExtraConstants.passwordRegexPattern;
    RegExp regExp = new RegExp(_pattern);
    if(!regExp.hasMatch(confirmPassword)) {
      return false;
    }
    return true;
  }

  final FormStatus formStatus;

  ChangePasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.formStatus = const InitialFormStatus(),
  });

  ChangePasswordState copyWith({
    String currentPassword,
    String newPassword,
    String confirmPassword,
    FormStatus formStatus,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}