import 'package:banking_app/features/home/models/bank_card_model.dart';
import 'package:banking_app/features/transaction_report/models/report_chart_item_model.dart';
import 'package:banking_app/features/transaction_report/models/transaction_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionReportCardProvider = Provider<BankCardModel>((ref) {
  return const BankCardModel(
    cardHolderName: 'John Smith',
    cardType: 'Amazon Platinium',
    cardNumber: '4756  ••••  ••••  9018',
    balance: '\$3.469,52',
    brand: 'VISA',
  );
});

final transactionBalanceProvider = Provider<String>((ref) {
  return '1000';
});
final reportChartProvider = Provider<List<ReportChartItemModel>>((ref) {
  return const [
    ReportChartItemModel(month: 'Jan', incomeHeight: 26, expenseHeight: 14),
    ReportChartItemModel(month: 'Feb', incomeHeight: 40, expenseHeight: 24),
    ReportChartItemModel(month: 'Mar', incomeHeight: 52, expenseHeight: 30),
    ReportChartItemModel(
      month: 'Apr',
      incomeHeight: 34,
      expenseHeight: 18,
      isSelected: true,
    ),
    ReportChartItemModel(month: 'May', incomeHeight: 20, expenseHeight: 12),
    ReportChartItemModel(month: 'Jun', incomeHeight: 42, expenseHeight: 22),
    ReportChartItemModel(month: 'Jul', incomeHeight: 22, expenseHeight: 12),
    ReportChartItemModel(month: 'Jun', incomeHeight: 36, expenseHeight: 18),
  ];
});

final transactionHistoryProvider =
    Provider<List<TransactionItemModel>>((ref) {
  return [
    // Today
    TransactionItemModel(
      sectionTitle: 'Today',
      title: 'Water Bill',
      status: 'Unsuccessfully',
      amount: '- \$280',
      icon: Icons.opacity,
      iconBgColor: const Color(0xff4338D8),
      isIncome: false,
    ),
    TransactionItemModel(
      sectionTitle: 'Today',
      title: 'Electric Bill',
      status: 'Successfully',
      amount: '- \$480',
      icon: Icons.electric_bolt,
      iconBgColor: const Color(0xff3B82F6),
      isIncome: false,
    ),
    TransactionItemModel(
      sectionTitle: 'Today',
      title: 'Internet Bill',
      status: 'Successfully',
      amount: '- \$100',
      icon: Icons.wifi,
      iconBgColor: const Color(0xff10B981),
      isIncome: false,
    ),

    // Yesterday
    TransactionItemModel(
      sectionTitle: 'Yesterday',
      title: 'Income: Salary Oct',
      status: '',
      amount: '+ \$1200',
      icon: Icons.attach_money,
      iconBgColor: const Color(0xffEF4444),
      isIncome: true,
    ),
    TransactionItemModel(
      sectionTitle: 'Yesterday',
      title: 'Income: Jane transfers',
      status: '',
      amount: '+ \$500',
      icon: Icons.credit_card,
      iconBgColor: const Color(0xffF59E0B),
      isIncome: true,
    ),
  ];
});
