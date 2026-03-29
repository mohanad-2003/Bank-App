import 'package:banking_app/features/data/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';

final signinProvider = StateNotifierProvider<SigninNotifier, SigninState>(
  (ref) => SigninNotifier(),
);

class SigninState {
  final bool isLoading;
  final bool isEnabled;

  const SigninState({
    this.isLoading = false,
    this.isEnabled = false,
  });

  SigninState copyWith({
    bool? isLoading,
    bool? isEnabled,
  }) {
    return SigninState(
      isLoading: isLoading ?? this.isLoading,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class SigninNotifier extends StateNotifier<SigninState> {
  final AuthService _authService = AuthService();

  SigninNotifier() : super(const SigninState());

  void updateButtonState({
    required String email,
    required String password,
  }) {
    final enabled = email.trim().isNotEmpty && password.trim().isNotEmpty;
    state = state.copyWith(isEnabled: enabled);
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      await _authService.signInWithEmail(
        email: email.trim(),
        password: password.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return 'Invalid email or password';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email';
      }
      return 'Something went wrong';
    } catch (_) {
      return 'Something went wrong';
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}