abstract class FormStatus {
  const FormStatus();
}

class InitialFormStatus extends FormStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormStatus {}

class SubmissionSuccess extends FormStatus {}

class SubmissionFailed extends FormStatus {
  final Exception exception;

  SubmissionFailed(this.exception);
}