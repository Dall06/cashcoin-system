import 'package:cc_flutter_mobile/bloc/user/edit/data/edit_data_event.dart';
import 'package:cc_flutter_mobile/bloc/user/edit/data/edit_data_state.dart';
import 'package:cc_flutter_mobile/bloc/user/edit/submit_data.dart';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDataBloc extends Bloc<EditDataEvent, EditDataState> {
  final UserRepository userRepository;

  EditDataBloc({this.userRepository}) : super(EditDataState());

  @override
  Stream<EditDataState> mapEventToState(EditDataEvent event) async* {
    // Username updated
    if (event is EmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is PhoneChanged) {
      yield state.copyWith(phone: event.phone);

      // Form submitted
    } else if (event is NameChanged) {
      yield state.copyWith(name: event.name);

      // Form submitted
    } else if (event is LastNameChanged) {
      yield state.copyWith(lastName: event.lastName);

      // Form submitted
    } else if (event is ChangeSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        UserData _userData = new UserData();
        UserAccount _userAccount = new UserAccount();
        _userData.name = state.name;
        _userData.lastName = state.lastName;
        _userAccount.phone = state.phone;
        _userAccount.email = state.email;
        _userData.userAccount = _userAccount;

        await userRepository.editAccountData(_userData);

        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
      yield state.copyWith(formStatus: InitialFormStatus());
    }
  }
}