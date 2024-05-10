import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

// 3- State Notifier Provider which is what we use outside
final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {

  // Here we are getting the reference to the login method of the auth provider
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(
    registerUserCallback: registerUserCallback
  );
});

// 1- create the state of this provider
class RegisterFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final PasswordRepeat passwordRepeat;
  final Fullname fullname;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordRepeat = const PasswordRepeat.pure(),
    this.fullname = const Fullname.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    PasswordRepeat? passwordRepeat,
    Fullname? fullname,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
    passwordRepeat: passwordRepeat ?? this.passwordRepeat,
    fullname: fullname ?? this.fullname,
  );

  @override
  String toString() {
    return '''
      LoginFormState: 
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      email: $email
      password: $password
      passwordRepeat: $passwordRepeat
      fullname: $fullname
    ''';
  }

}

// 2- how to implement the notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback
}): super(RegisterFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([
        newEmail,
        state.password,
        state.passwordRepeat,
        state.fullname
      ]),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([
        newPassword,
        state.passwordRepeat,
        state.email,
        state.fullname
      ]),
    );
  }

  onPasswordRepeatChanged(String value) {
    final newPasswordRepeat = PasswordRepeat.dirty(value);
    state = state.copyWith(
      passwordRepeat: newPasswordRepeat,
      isValid: Formz.validate([
        newPasswordRepeat,
        state.email,
        state.password,
        state.fullname
      ]),
    );
  }

  onFullnameChanged(String value) {
    final newFullname = Fullname.dirty(value);
    state = state.copyWith(
      fullname: newFullname,
      isValid: Formz.validate([
        newFullname,
        state.password,
        state.passwordRepeat,
        state.email
      ]),
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;
    if (state.password.value != state.passwordRepeat.value) return;

    await registerUserCallback(
      state.email.value,
      state.password.value,
      state.fullname.value,
    );
  }

  // Allow to verify all field although their are pure
  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final passwordRepeat = PasswordRepeat.dirty(state.passwordRepeat.value);
    final fullname = Fullname.dirty(state.fullname.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      passwordRepeat: passwordRepeat,
      fullname: fullname,
      isValid: Formz.validate([email, password, passwordRepeat, fullname]),
    );

  }
  
}
