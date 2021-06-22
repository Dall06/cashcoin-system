abstract class FormStatus {
  const FormStatus();
}

class InitialFormStatus extends FormStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormStatus {}

class SubmissionCreateSuccess extends FormStatus {}

class SubmissionCreateFailed extends FormStatus {
  final Exception exception;

  SubmissionCreateFailed(this.exception);
}