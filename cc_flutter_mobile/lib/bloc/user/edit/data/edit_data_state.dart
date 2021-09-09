import 'package:cc_flutter_mobile/bloc/user/edit/submit_data.dart';
import 'package:cc_flutter_mobile/config/extra_constants.dart';

class EditDataState {
  final String email;
  bool get isValidEmail {
    final Pattern _pattern = ExtraConstants.emailRegexPattern;
    RegExp regExp = new RegExp(_pattern);
    if(!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }
  final String phone;
  final String name;
  final String lastName;
  final FormStatus formStatus;

  EditDataState({
    this.email = '',
    this.phone = '',
    this.name = '',
    this.lastName = '',
    this.formStatus = const InitialFormStatus(),
  });

  EditDataState copyWith({
    String email,
    String phone,
    String name,
    String lastName,
    FormStatus formStatus,
  }) {
    return EditDataState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}