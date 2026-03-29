import 'package:banking_app/features/home/models/bank_card_model.dart';
import 'package:banking_app/features/home/models/home_action_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeUserNameProvider = Provider<String>((ref) {
  return 'Push Puttichai';
});

final notificationCountProvider = Provider<int>((ref) {
  return 3;
});

final bankCardProvider = Provider<BankCardModel>((ref) {
  return const BankCardModel(
    cardHolderName: 'John Smith',
    cardType: 'Amazon Platinium',
    cardNumber: '4756  ••••  ••••  9018',
    balance: '\$3.469,52',
    brand: 'VISA',
  );
});

final homeActionsProvider = Provider<List<HomeActionItem>>((ref) {
  return [
    HomeActionItem(
      title: 'Account\nand Card',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xff3B2CCB),
      route: '/account-card',
    ),
    HomeActionItem(
      title: 'Transfer',
      icon: Icons.copy_all_rounded,
      color: Color(0xffFF4D7E),
      route: '/transfer',
    ),
    HomeActionItem( 
      title: 'Withdraw',
      icon: Icons.account_balance_rounded,
      color: Color(0xff1E90FF),
      route: '/withdraw',
    ),
    HomeActionItem(
      title: 'Mobile\nprepaid',
      icon: Icons.attach_money_rounded,
      color: Color(0xffF5A623),
      route: '/mobile-prepaid',
    ),
    HomeActionItem(
      title: 'Pay the\nbill',
      icon: Icons.receipt_long_rounded,
      color: Color(0xff52D5BA),
      route: '/pay-bill',
    ),
    HomeActionItem(
      title: 'Save\nonline',
      icon: Icons.savings_rounded,
      color: Color(0xff5E56D8),
      route: '/save-online',
    ),
    HomeActionItem(
      title: 'Credit\ncard',
      icon: Icons.credit_card_rounded,
      color: Color(0xffF56A1C),
      route: '/credit',
    ),
    HomeActionItem(
      title: 'Transaction\nreport',
      icon: Icons.article_rounded,
      color: Color(0xff3B2CCB),
      route: '/transaction-report',
    ),
    HomeActionItem(
      title: 'Beneficiary',
      icon: Icons.perm_contact_calendar_rounded,
      color: Color(0xffFF4D7E),
      route: '/beneficiary',
    ),
  ];
});
