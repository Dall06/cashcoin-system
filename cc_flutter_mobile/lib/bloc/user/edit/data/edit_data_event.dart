abstract class EditDataEvent {}

class EmailChanged extends EditDataEvent {
  final String email;

  EmailChanged({this.email});
}

class PhoneChanged extends EditDataEvent {
  final String phone;

  PhoneChanged({this.phone});
}

class NameChanged extends EditDataEvent {
  final String name;

  NameChanged({this.name});
}

class LastNameChanged extends EditDataEvent {
  final String lastName;

  LastNameChanged({this.lastName});
}

class ChangeSubmitted extends EditDataEvent {}