import 'package:banking_app/features/pay-bill/models/bill_category_model.dart';
import 'package:banking_app/features/pay-bill/models/internet_bill_model.dart';
import 'package:banking_app/features/pay-bill/models/pay_bill_account_model.dart';
import 'package:banking_app/features/pay-bill/models/payment_history_item_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class PayBillState {
  final List<BillCategoryModel> categories;
  final List<PaymentHistoryItemModel> history;
  final PaymentHistoryType selectedHistoryType;
  final List<PayBillAccountModel> accounts;
  final PayBillAccountModel? selectedAccount;
  final InternetBillModel? internetBill;
  final String internetCompany;
  final String internetBillCode;
  final String otp;
  final bool isLoading;

  const PayBillState({
    required this.categories,
    required this.history,
    required this.selectedHistoryType,
    required this.accounts,
    required this.selectedAccount,
    required this.internetBill,
    required this.internetCompany,
    required this.internetBillCode,
    required this.otp,
    required this.isLoading,
  });

  factory PayBillState.initial() {
    return const PayBillState(
      categories: [
        BillCategoryModel(
          id: '1',
          title: 'Electric bill',
          subtitle: 'Pay electric bill this month',
          imagePath: 'assets/electric.png',
          route: '/payment-history',
        ),
        BillCategoryModel(
          id: '2',
          title: 'Water bill',
          subtitle: 'Pay water bill this month',
          imagePath: 'assets/water.png',
          route: '/payment-history',
        ),
        BillCategoryModel(
          id: '3',
          title: 'Mobile bill',
          subtitle: 'Pay mobile bill this month',
          imagePath: 'assets/mobile-bill.png',
          route: '/payment-history',
        ),
        BillCategoryModel(
          id: '4',
          title: 'Internet bill',
          subtitle: 'Pay internet bill this month',
          imagePath: 'assets/internet-bill.png',
          route: '/internet-bill-form',
        ),
      ],
      history: [
        PaymentHistoryItemModel(
          id: '1',
          type: PaymentHistoryType.electric,
          month: 'October',
          date: '30/10/2019',
          status: 'Unsuccessfully',
          isSuccessful: false,
          amount: '\$480',
        ),
        PaymentHistoryItemModel(
          id: '2',
          type: PaymentHistoryType.electric,
          month: 'September',
          date: '30/09/2019',
          status: 'Successfully',
          isSuccessful: true,
          amount: '\$480',
        ),
        PaymentHistoryItemModel(
          id: '3',
          type: PaymentHistoryType.internet,
          month: 'October',
          date: '30/10/2019',
          status: 'Unsuccessfully',
          isSuccessful: false,
          amount: '\$50',
          company: 'Capi Telecom',
        ),
        PaymentHistoryItemModel(
          id: '4',
          type: PaymentHistoryType.internet,
          month: 'September',
          date: '30/09/2019',
          status: 'Successfully',
          isSuccessful: true,
          amount: '\$50',
          company: 'Capi Telecom',
        ),
        PaymentHistoryItemModel(
          id: '5',
          type: PaymentHistoryType.internet,
          month: 'August',
          date: '30/08/2019',
          status: 'Successfully',
          isSuccessful: true,
          amount: '\$50',
          company: 'Capi Telecom',
        ),
      ],
      selectedHistoryType: PaymentHistoryType.electric,
      accounts: [
        PayBillAccountModel(
          id: '1',
          accountNumber: '4411 0000 1234',
        ),
      ],
      selectedAccount: null,
      internetBill: null,
      internetCompany: '',
      internetBillCode: '',
      otp: '',
      isLoading: false,
    );
  }

  PayBillState copyWith({
    List<BillCategoryModel>? categories,
    List<PaymentHistoryItemModel>? history,
    PaymentHistoryType? selectedHistoryType,
    List<PayBillAccountModel>? accounts,
    PayBillAccountModel? selectedAccount,
    bool clearSelectedAccount = false,
    InternetBillModel? internetBill,
    bool clearInternetBill = false,
    String? internetCompany,
    String? internetBillCode,
    String? otp,
    bool? isLoading,
  }) {
    return PayBillState(
      categories: categories ?? this.categories,
      history: history ?? this.history,
      selectedHistoryType: selectedHistoryType ?? this.selectedHistoryType,
      accounts: accounts ?? this.accounts,
      selectedAccount: clearSelectedAccount
          ? null
          : (selectedAccount ?? this.selectedAccount),
      internetBill: clearInternetBill ? null : (internetBill ?? this.internetBill),
      internetCompany: internetCompany ?? this.internetCompany,
      internetBillCode: internetBillCode ?? this.internetBillCode,
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  List<PaymentHistoryItemModel> get filteredHistory {
    return history.where((item) => item.type == selectedHistoryType).toList();
  }

  bool get canCheckInternetBill =>
      internetCompany.trim().isNotEmpty && internetBillCode.trim().isNotEmpty;

  bool get canPayInternetBill =>
      internetBill != null &&
      selectedAccount != null &&
      otp.trim().isNotEmpty;
}

class PayBillNotifier extends StateNotifier<PayBillState> {
  PayBillNotifier() : super(PayBillState.initial());

  void selectHistoryType(PaymentHistoryType type) {
    state = state.copyWith(selectedHistoryType: type);
  }

  void updateInternetCompany(String value) {
    state = state.copyWith(internetCompany: value);
  }

  void updateInternetBillCode(String value) {
    state = state.copyWith(internetBillCode: value);
  }

  Future<bool> checkInternetBill() async {
    if (!state.canCheckInternetBill) return false;

    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(
      isLoading: false,
      internetBill: const InternetBillModel(
        name: 'Jackson Maine',
        address: '403 East 4th Street,\nSanta Ana',
        phoneNumber: '+8424599721',
        code: '#2343543',
        fromDate: '01/10/2019',
        toDate: '01/11/2019',
        fee: '\$50',
        tax: '\$10',
        total: '\$60',
      ),
    );

    return true;
  }

  void selectAccount(PayBillAccountModel account) {
    state = state.copyWith(selectedAccount: account);
  }

  void updateOtp(String value) {
    state = state.copyWith(otp: value);
  }

  Future<void> getOtp() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 700));
    state = state.copyWith(isLoading: false);
  }

  Future<bool> submitInternetBillPayment() async {
    if (!state.canPayInternetBill) return false;
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 900));
    state = state.copyWith(isLoading: false);
    return true;
  }

  void resetInternetBillFlow() {
    state = state.copyWith(
      clearInternetBill: true,
      clearSelectedAccount: true,
      internetCompany: '',
      internetBillCode: '',
      otp: '',
    );
  }
}

final payBillProvider =
    StateNotifierProvider<PayBillNotifier, PayBillState>(
  (ref) => PayBillNotifier(),
);