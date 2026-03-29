import 'package:banking_app/features/withdraw/models/withdraw_account_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class WithdrawState {
  final List<WithdrawAccountModel> accounts;
  final WithdrawAccountModel? selectedAccount;
  final String phoneNumber;
  final String manualAmount;
  final int? selectedPresetAmount;
  final bool isSubmitting;

  const WithdrawState({
    required this.accounts,
    required this.selectedAccount,
    required this.phoneNumber,
    required this.manualAmount,
    required this.selectedPresetAmount,
    required this.isSubmitting,
  });

  factory WithdrawState.initial() {
    return const WithdrawState(
      accounts: [
        WithdrawAccountModel(
          id: '1',
          accountNumber: '1900 8988 5456',
          availableBalance: 10000,
        ),
        WithdrawAccountModel(
          id: '2',
          accountNumber: '1900 8112 5222',
          availableBalance: 7000,
        ),
        WithdrawAccountModel(
          id: '3',
          accountNumber: '4411 0000 1234',
          availableBalance: 10000,
        ),
        WithdrawAccountModel(
          id: '4',
          accountNumber: '1900 8988 5456',
          availableBalance: 5200,
        ),
      ],
      selectedAccount: null,
      phoneNumber: '',
      manualAmount: '',
      selectedPresetAmount: null,
      isSubmitting: false,
    );
  }

  WithdrawState copyWith({
    List<WithdrawAccountModel>? accounts,
    WithdrawAccountModel? selectedAccount,
    bool clearSelectedAccount = false,
    String? phoneNumber,
    String? manualAmount,
    int? selectedPresetAmount,
    bool clearSelectedPresetAmount = false,
    bool? isSubmitting,
  }) {
    return WithdrawState(
      accounts: accounts ?? this.accounts,
      selectedAccount: clearSelectedAccount
          ? null
          : (selectedAccount ?? this.selectedAccount),
      phoneNumber: phoneNumber ?? this.phoneNumber,
      manualAmount: manualAmount ?? this.manualAmount,
      selectedPresetAmount: clearSelectedPresetAmount
          ? null
          : (selectedPresetAmount ?? this.selectedPresetAmount),
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  bool get hasManualAmount => manualAmount.trim().isNotEmpty;

  int? get parsedManualAmount {
    final normalized = manualAmount.replaceAll(RegExp(r'[^0-9]'), '');
    if (normalized.isEmpty) return null;
    return int.tryParse(normalized);
  }

  int? get finalAmount => hasManualAmount ? parsedManualAmount : selectedPresetAmount;

  bool get isValid =>
      selectedAccount != null &&
      phoneNumber.trim().isNotEmpty &&
      finalAmount != null &&
      finalAmount! > 0;
}

class WithdrawNotifier extends StateNotifier<WithdrawState> {
  WithdrawNotifier() : super(WithdrawState.initial());

  void selectAccount(WithdrawAccountModel account) {
    state = state.copyWith(selectedAccount: account);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void selectPresetAmount(int amount) {
    state = state.copyWith(
      selectedPresetAmount: amount,
      manualAmount: '',
    );
  }

  void updateManualAmount(String value) {
    state = state.copyWith(
      manualAmount: value,
      clearSelectedPresetAmount: true,
    );
  }

  Future<bool> submitWithdraw() async {
    if (!state.isValid) return false;

    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(milliseconds: 700));
    state = state.copyWith(isSubmitting: false);
    return true;
  }

  void reset() {
    state = WithdrawState.initial();
  }
}

final withdrawProvider =
    StateNotifierProvider<WithdrawNotifier, WithdrawState>(
  (ref) => WithdrawNotifier(),
);