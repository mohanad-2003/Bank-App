import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final appInfoProvider = Provider<Map<String, String>>((ref) {
  return const {
    'appName': 'CaBank E-mobile Banking',
    'dateOfManufacture': 'Dec 2019',
    'version': '9.0.2',
    'language': 'English',
    'customerCare': '19008989',
  };
});

class ChangePasswordState {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  bool get canSubmit =>
      currentPassword.trim().isNotEmpty &&
      newPassword.trim().isNotEmpty &&
      confirmPassword.trim().isNotEmpty &&
      newPassword == confirmPassword;

  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
  return ChangePasswordNotifier();
});

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  ChangePasswordNotifier() : super(const ChangePasswordState());

  void updateCurrentPassword(String value) {
    state = state.copyWith(currentPassword: value);
  }

  void updateNewPassword(String value) {
    state = state.copyWith(newPassword: value);
  }

  void updateConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
  }

  void reset() {
    state = const ChangePasswordState();
  }
}