import 'package:cc_flutter_mobile/data/model/transaction.dart';
import 'package:cc_flutter_mobile/data/model/user.dart';
import 'package:cc_flutter_mobile/data/repositories/transaction_repository.dart';
import 'package:cc_flutter_mobile/bloc/transaction/make/transaction/make_transaction_event.dart';
import 'package:cc_flutter_mobile/bloc/transaction/make/transaction/make_transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../submit_transaction.dart';

class MakeTransactionBloc
    extends Bloc<MakeTransactionEvent, MakeTransactionState> {
  final TransactionRepository transactionRepository;

  MakeTransactionBloc({this.transactionRepository})
      : super(MakeTransactionState());

  @override
  Stream<MakeTransactionState> mapEventToState(
      MakeTransactionEvent event) async* {
    // Username updated
    if (event is QuantityChanged) {
      print(state.quantity);
      yield state.copyWith(quantity: event.quantity);

      // Password updated
    } else if (event is TransactionTypeIDChanged) {
      print(state.transactionType);
      yield state.copyWith(transactionType: event.transactionType);

      // Form submitted
    } else if (event is DestinationCodeChanged) {
      print(state.destinationCode);
      yield state.copyWith(destinationCode: event.code);

      // Form submitted
    } else if (event is ConceptChanged) {
      print(state.concept);
      yield state.copyWith(concept: event.concept);

      // Form submitted
    } else if (event is OriginCodeChanged) {
      yield state.copyWith(originCode: event.code);

      // Form submitted
    } else if (event is TransactionSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final storage = new FlutterSecureStorage();
        String currentToken = await storage.read(key: 'code');

        final TransactionType transactionType = new TransactionType(id: 1);

        final TransactionOrder transactionOrder = new TransactionOrder(
            quantity: state.quantity, transactionType: transactionType);

        final UserData destination = new UserData(code: state.destinationCode);
        final UserData origin = new UserData(code: currentToken);

        final TransactionDetail transactionDetail = new TransactionDetail(
          concept: state.concept,
          destination: destination,
          origin: origin,
          order: transactionOrder,
        );

        await transactionRepository.makeTransaction(transactionDetail);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
      yield state.copyWith(formStatus: InitialFormStatus());
    }
  }
}
