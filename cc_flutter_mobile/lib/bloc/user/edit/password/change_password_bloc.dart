import 'package:cc_flutter_mobile/bloc/user/edit/submit_password.dart';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/repositories/user_repository.dart';
import 'package:cc_flutter_mobile/bloc/user/edit/password/change_password_event.dart';
import 'package:cc_flutter_mobile/bloc/user/edit/password/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;

  ChangePasswordBloc({this.userRepository}) : super(ChangePasswordState());

  @override
  Stream<ChangePasswordState> mapEventToState(ChangePasswordEvent event) async* {
    // Username updated
    if (event is CurrentPasswordChanged) {
      yield state.copyWith(currentPassword: event.currentPassword);

      // Password updated
    } else if (event is NewPasswordChanged) {
      yield state.copyWith(newPassword: event.newPassword);

      // Form submitted
    } else if (event is ConfirmPasswordChanged) {
      yield state.copyWith(confirmPassword: event.confirmPassword);

      // Form submitted
    } else if (event is ChangeSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        if(state.newPassword != state.confirmPassword) {
          throw Exception('Password do not match');
        }

        final storage = new FlutterSecureStorage();
        String currentToken = await storage.read(key: 'set-token');
        Map<String, dynamic> decodedToken = JwtDecoder.decode(currentToken);
        String email = decodedToken['email'];

        final UserAccount userAccount = new UserAccount(
          email: email,
          password: state.currentPassword
        );
        final UserPassUpdate userPassUpdate = new UserPassUpdate(
          userAccount: userAccount,
          newPassword: state.newPassword,
        );

        await userRepository.changeAccountPassword(userPassUpdate);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
      yield state.copyWith(formStatus: InitialFormStatus());
    }
  }
}