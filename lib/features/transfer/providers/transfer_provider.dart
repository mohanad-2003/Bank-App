import 'package:banking_app/features/transfer/models/beneficiary_model.dart';
import 'package:banking_app/features/transfer/models/transfer_account_model.dart';
import 'package:banking_app/features/transfer/models/transfer_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final transferAccountsProvider = Provider<List<TransferAccountModel>>((ref) {
  return const [
    TransferAccountModel(
      title: 'VISA •••• •••• •••• 1234',
      balance: '10,000\$',
    ),
    TransferAccountModel(title: 'Account 1234 5678 5689', balance: '10,000\$'),
  ];
});

final transferTypesProvider = Provider<List<TransferTypeModel>>((ref) {
  return [
    TransferTypeModel(
      id: 'my_card',
      title: 'Transfer via\ncard number',
      icon: Icons.credit_card_rounded,
      color: Color(0xff4A3FE2),
    ),
    TransferTypeModel(
      id: 'same_bank',
      title: 'Transfer to\nthe same bank',
      icon: Icons.person_rounded,
      color: Color(0xffD8D8D8),
    ),
    TransferTypeModel(
      id: 'other_bank',
      title: 'Transfer to\nother bank',
      icon: Icons.account_balance_rounded,
      color: Color(0xffF5A623),
    ),
  ];
});

final beneficiariesProvider = Provider<List<BeneficiaryModel>>((ref) {
  return const [
    BeneficiaryModel(name: 'Emma', imagePath: 'assets/emma.png'),
    BeneficiaryModel(name: 'Justin', imagePath: 'assets/justin.png'),
  ];
});

final banksProvider = Provider<List<String>>((ref) {
  return const [
    'Fifth Third',
    'Bank of the West',
    'Wells Fago',
    'JP Morgan Chao',
    'US bank',
    'HSBS bank',
    'Citybank',
    'Ame Express',
  ];
});

class TransferState {
  final String selectedAccount;
  final String selectedTransferType;
  final int selectedBeneficiaryIndex;
  final String selectedBank;
  final String selectedBranch;
  final String name;
  final String cardNumber;
  final String amount;
  final String content;
  final bool saveBeneficiary;
  final String otp;
  final bool otpRequested;
  final bool useBiometric;

  const TransferState({
    this.selectedAccount = '',
    this.selectedTransferType = '',
    this.selectedBeneficiaryIndex = -1,
    this.selectedBank = '',
    this.selectedBranch = '',
    this.name = '',
    this.cardNumber = '',
    this.amount = '',
    this.content = '',
    this.saveBeneficiary = false,
    this.otp = '',
    this.otpRequested = false,
    this.useBiometric = false,
  });

  bool get isOtherBank => selectedTransferType == 'other_bank';

  bool get canConfirm {
    final hasCommonFields =
        selectedAccount.isNotEmpty &&
        selectedTransferType.isNotEmpty &&
        name.trim().isNotEmpty &&
        cardNumber.trim().isNotEmpty &&
        amount.trim().isNotEmpty &&
        content.trim().isNotEmpty;

    if (!hasCommonFields) return false;

    if (isOtherBank) {
      return selectedBank.isNotEmpty && selectedBranch.isNotEmpty;
    }

    return true;
  }

  bool get canFinalConfirm => otp.trim().length >= 4 || useBiometric;

  TransferState copyWith({
    String? selectedAccount,
    String? selectedTransferType,
    int? selectedBeneficiaryIndex,
    String? selectedBank,
    String? selectedBranch,
    String? name,
    String? cardNumber,
    String? amount,
    String? content,
    bool? saveBeneficiary,
    String? otp,
    bool? otpRequested,
    bool? useBiometric,
  }) {
    return TransferState(
      selectedAccount: selectedAccount ?? this.selectedAccount,
      selectedTransferType: selectedTransferType ?? this.selectedTransferType,
      selectedBeneficiaryIndex:
          selectedBeneficiaryIndex ?? this.selectedBeneficiaryIndex,
      selectedBank: selectedBank ?? this.selectedBank,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      amount: amount ?? this.amount,
      content: content ?? this.content,
      saveBeneficiary: saveBeneficiary ?? this.saveBeneficiary,
      otp: otp ?? this.otp,
      otpRequested: otpRequested ?? this.otpRequested,
      useBiometric: useBiometric ?? this.useBiometric,
    );
  }
}

final transferProvider = StateNotifierProvider<TransferNotifier, TransferState>(
  (ref) {
    final accounts = ref.read(transferAccountsProvider);
    return TransferNotifier(
      initialAccount: accounts.isNotEmpty ? accounts.first.title : '',
    );
  },
);

class TransferNotifier extends StateNotifier<TransferState> {
  TransferNotifier({required String initialAccount})
    : super(TransferState(selectedAccount: initialAccount));

  void selectAccount(String value) {
    state = state.copyWith(selectedAccount: value);
  }

  void selectTransferType(String id) {
    state = state.copyWith(selectedTransferType: id);
  }

  void selectBeneficiary(int index, String name) {
    state = state.copyWith(selectedBeneficiaryIndex: index, name: name);
  }

  void selectBank(String value) {
    state = state.copyWith(selectedBank: value);
  }

  void selectBranch(String value) {
    state = state.copyWith(selectedBranch: value);
  }

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateCardNumber(String value) {
    state = state.copyWith(cardNumber: value);
  }

  void updateAmount(String value) {
    state = state.copyWith(amount: value);
  }

  void updateContent(String value) {
    state = state.copyWith(content: value);
  }

  void toggleSaveBeneficiary() {
    state = state.copyWith(saveBeneficiary: !state.saveBeneficiary);
  }

  void updateOtp(String value) {
    state = state.copyWith(otp: value);
  }

  void requestOtp() {
    state = state.copyWith(otpRequested: true);
  }

  void enableBiometric() {
    state = state.copyWith(useBiometric: true);
  }

  void resetVerification() {
    state = state.copyWith(otp: '', otpRequested: false, useBiometric: false);
  }

  String amountInWords() {
    if (state.amount.trim().isEmpty) return '';
    if (state.amount == '1000') return 'One thousand dollar';
    if (state.amount == '200') return 'Two hundred dollar';
    return '';
  }

  String maskedFromAccount() {
    if (state.selectedAccount.contains('1234')) {
      return '•••• •••• 6789';
    }
    return '•••• •••• 6789';
  }

  String transactionFee() {
    return '10\$';
  }
}
