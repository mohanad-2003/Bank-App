import 'package:banking_app/features/data/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';

final signupProvider =
    StateNotifierProvider<SignupNotifier, SignupState>((ref) {
  return SignupNotifier(AuthService());
});

class SignupState {
  final bool agreeTerms;
  final bool isButtonEnabled;
  final bool isLoading;

  const SignupState({
    this.agreeTerms = false,
    this.isButtonEnabled = false,
    this.isLoading = false,
  });

  SignupState copyWith({
    bool? agreeTerms,
    bool? isButtonEnabled,
    bool? isLoading,
  }) {
    return SignupState(
      agreeTerms: agreeTerms ?? this.agreeTerms,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SignupNotifier extends StateNotifier<SignupState> {
  final AuthService _authService;

  SignupNotifier(this._authService) : super(const SignupState());

  void toggleAgreeTerms({
    required String name,
    required String email,
    required String password,
  }) {
    final newAgreeTerms = !state.agreeTerms;
    final isEnabled = _validateFields(
      name: name,
      email: email,
      password: password,
      agreeTerms: newAgreeTerms,
    );

    state = state.copyWith(
      agreeTerms: newAgreeTerms,
      isButtonEnabled: isEnabled,
    );
  }

  void updateButtonState({
    required String name,
    required String email,
    required String password,
  }) {
    final enabled = _validateFields(
      name: name,
      email: email,
      password: password,
      agreeTerms: state.agreeTerms,
    );

    state = state.copyWith(isButtonEnabled: enabled);
  }

  bool _validateFields({
    required String name,
    required String email,
    required String password,
    required bool agreeTerms,
  }) {
    return name.trim().isNotEmpty &&
        email.trim().isNotEmpty &&
        password.trim().isNotEmpty &&
        agreeTerms;
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      final credential = await _authService.signUpWithEmail(
        email: email.trim(),
        password: password.trim(),
      );

      await credential.user?.updateDisplayName(name.trim());

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'This email is already in use';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email address';
      } else if (e.code == 'weak-password') {
        return 'Password is too weak';
      }
      return 'Something went wrong';
    } catch (_) {
      return 'Something went wrong';
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}