import 'package:banking_app/features/mobile-prepaid/models/beneficiary_prepaid_model.dart';
import 'package:banking_app/features/mobile-prepaid/models/mobile_prepaid_account_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class MobilePrepaidState {
  final List<MobilePrepaidAccountModel> accounts;
  final List<BeneficiaryPrepaidModel> beneficiaries;
  final MobilePrepaidAccountModel? selectedAccount;
  final BeneficiaryPrepaidModel? selectedBeneficiary;
  final String phoneNumber;
  final int? selectedAmount;
  final String otp;
  final bool isSubmitting;

  const MobilePrepaidState({
    required this.accounts,
    required this.beneficiaries,
    required this.selectedAccount,
    required this.selectedBeneficiary,
    required this.phoneNumber,
    required this.selectedAmount,
    required this.otp,
    required this.isSubmitting,
  });

  factory MobilePrepaidState.initial() {
    return const MobilePrepaidState(
      accounts: [
        MobilePrepaidAccountModel(
          id: '1',
          accountNumber: '**** **** 1234',
          availableBalance: 10000,
        ),
      ],
      beneficiaries: [
        BeneficiaryPrepaidModel(
          id: '1',
          name: 'Emma',
          imagePath: 'assets/emma.png',
          phoneNumber: '+8564757899',
        ),
        BeneficiaryPrepaidModel(
          id: '2',
          name: 'Justin',
          imagePath: 'assets/justin.png',
          phoneNumber: '+8564757000',
        ),
      ],
      selectedAccount: null,
      selectedBeneficiary: null,
      phoneNumber: '',
      selectedAmount: null,
      otp: '',
      isSubmitting: false,
    );
  }

  MobilePrepaidState copyWith({
    List<MobilePrepaidAccountModel>? accounts,
    List<BeneficiaryPrepaidModel>? beneficiaries,
    MobilePrepaidAccountModel? selectedAccount,
    bool clearSelectedAccount = false,
    BeneficiaryPrepaidModel? selectedBeneficiary,
    bool clearSelectedBeneficiary = false,
    String? phoneNumber,
    int? selectedAmount,
    bool clearSelectedAmount = false,
    String? otp,
    bool? isSubmitting,
  }) {
    return MobilePrepaidState(
      accounts: accounts ?? this.accounts,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      selectedAccount: clearSelectedAccount
          ? null
          : (selectedAccount ?? this.selectedAccount),
      selectedBeneficiary: clearSelectedBeneficiary
          ? null
          : (selectedBeneficiary ?? this.selectedBeneficiary),
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedAmount: clearSelectedAmount
          ? null
          : (selectedAmount ?? this.selectedAmount),
      otp: otp ?? this.otp,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  bool get canContinueToConfirm =>
      selectedAccount != null &&
      phoneNumber.trim().isNotEmpty &&
      selectedAmount != null;

  bool get canSubmitPayment => otp.trim().isNotEmpty;
}

class MobilePrepaidNotifier extends StateNotifier<MobilePrepaidState> {
  MobilePrepaidNotifier() : super(MobilePrepaidState.initial());

  void selectAccount(MobilePrepaidAccountModel account) {
    state = state.copyWith(selectedAccount: account);
  }

  void selectBeneficiary(BeneficiaryPrepaidModel beneficiary) {
    state = state.copyWith(
      selectedBeneficiary: beneficiary,
      phoneNumber: beneficiary.phoneNumber,
    );
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value, clearSelectedBeneficiary: true);
  }

  void selectAmount(int amount) {
    state = state.copyWith(selectedAmount: amount);
  }

  void updateOtp(String value) {
    state = state.copyWith(otp: value);
  }

  Future<void> getOtp() async {
    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(milliseconds: 700));
    state = state.copyWith(isSubmitting: false);
  }

  Future<bool> submitPayment() async {
    if (!state.canSubmitPayment) return false;
    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(milliseconds: 900));
    state = state.copyWith(isSubmitting: false);
    return true;
  }

  void reset() {
    state = MobilePrepaidState.initial();
  }
}

final mobilePrepaidProvider =
    StateNotifierProvider<MobilePrepaidNotifier, MobilePrepaidState>(
      (ref) => MobilePrepaidNotifier(),
    );
