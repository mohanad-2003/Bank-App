import 'package:banking_app/features/beneficiary-screen/models/beneficiary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AddBeneficiaryState {
  final String imagePath;
  final BeneficiaryTransferType selectedType;
  final String bankName;
  final String branchName;
  final String transactionName;
  final String cardNumber;

  const AddBeneficiaryState({
    required this.imagePath,
    required this.selectedType,
    required this.bankName,
    required this.branchName,
    required this.transactionName,
    required this.cardNumber,
  });

  factory AddBeneficiaryState.initial() {
    return const AddBeneficiaryState(
      imagePath: '',
      selectedType: BeneficiaryTransferType.anotherBank,
      bankName: '',
      branchName: '',
      transactionName: '',
      cardNumber: '',
    );
  }

  AddBeneficiaryState copyWith({
    String? imagePath,
    BeneficiaryTransferType? selectedType,
    String? bankName,
    String? branchName,
    String? transactionName,
    String? cardNumber,
  }) {
    return AddBeneficiaryState(
      imagePath: imagePath ?? this.imagePath,
      selectedType: selectedType ?? this.selectedType,
      bankName: bankName ?? this.bankName,
      branchName: branchName ?? this.branchName,
      transactionName: transactionName ?? this.transactionName,
      cardNumber: cardNumber ?? this.cardNumber,
    );
  }

  bool get isValid =>
      imagePath.isNotEmpty &&
      bankName.trim().isNotEmpty &&
      branchName.trim().isNotEmpty &&
      transactionName.trim().isNotEmpty &&
      cardNumber.trim().isNotEmpty;
}

class AddBeneficiaryNotifier extends StateNotifier<AddBeneficiaryState> {
  AddBeneficiaryNotifier() : super(AddBeneficiaryState.initial());

  void updateImage(String value) {
    state = state.copyWith(imagePath: value);
  }

  void updateType(BeneficiaryTransferType value) {
    state = state.copyWith(selectedType: value);
  }

  void updateBankName(String value) {
    state = state.copyWith(bankName: value);
  }

  void updateBranchName(String value) {
    state = state.copyWith(branchName: value);
  }

  void updateTransactionName(String value) {
    state = state.copyWith(transactionName: value);
  }

  void updateCardNumber(String value) {
    state = state.copyWith(cardNumber: value);
  }

  void fillMockData() {
    state = state.copyWith(
      imagePath: 'assets/push.png',
      bankName: 'Citibank',
      branchName: 'New York',
      transactionName: 'Push Putchai',
      cardNumber: '1235 6478 990',
      selectedType: BeneficiaryTransferType.anotherBank,
    );
  }

  void reset() {
    state = AddBeneficiaryState.initial();
  }
}

final beneficiaryProvider = Provider<List<BeneficiaryModel>>((ref) {
  return const [
    BeneficiaryModel(
      name: 'Push',
      number: '12788980890',
      image: 'assets/push.png',
      groupType: BeneficiaryGroupType.cardNumber,
    ),
    BeneficiaryModel(
      name: 'Olivia',
      number: '0345976231',
      image: 'assets/olivia.png',
      groupType: BeneficiaryGroupType.cardNumber,
    ),
    BeneficiaryModel(
      name: 'Alexander',
      number: '12788980890',
      image: 'assets/alexander.png',
      groupType: BeneficiaryGroupType.sameBank,
    ),
    BeneficiaryModel(
      name: 'Harper',
      number: '0345976231',
      image: 'assets/harper.png',
      groupType: BeneficiaryGroupType.sameBank,
    ),
    BeneficiaryModel(
      name: 'Thomas',
      number: '12788980890',
      image: 'assets/thomas.png',
      groupType: BeneficiaryGroupType.anotherBank,
    ),
    BeneficiaryModel(
      name: 'Sanmatha',
      number: '0345976231',
      image: 'assets/harper.png',
      groupType: BeneficiaryGroupType.anotherBank,
    ),
    BeneficiaryModel(
      name: 'Justin Biber',
      number: '12788980890',
      image: 'assets/alexander.png',
      groupType: BeneficiaryGroupType.anotherBank,
    ),
  ];
});

final addBeneficiaryProvider =
    StateNotifierProvider<AddBeneficiaryNotifier, AddBeneficiaryState>(
  (ref) => AddBeneficiaryNotifier(),
);