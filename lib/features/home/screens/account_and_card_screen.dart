import 'package:banking_app/features/home/widgets/bank_and_card_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:banking_app/features/home/models/account_item_model.dart';
import 'package:banking_app/features/home/models/card_item_model.dart';

import 'package:banking_app/features/home/widgets/account_card_segmented_control.dart';
import 'package:banking_app/features/home/widgets/account_info_card.dart';
import 'package:banking_app/features/home/widgets/primary_action_button.dart';
import 'package:banking_app/features/home/widgets/profile_header.dart';
import 'package:banking_app/features/home/widgets/screen_header.dart';

class AccountAndCardScreen extends StatefulWidget {
  const AccountAndCardScreen({super.key});

  @override
  State<AccountAndCardScreen> createState() => _AccountAndCardScreenState();
}

class _AccountAndCardScreenState extends State<AccountAndCardScreen> {
  bool isCardTab = false;

  final List<AccountItemModel> _accounts = const [
    AccountItemModel(
      title: 'Account 1',
      accountNumber: '1900 8988 1234',
      balance: '\$20,000',
      branch: 'New York',
    ),
    AccountItemModel(
      title: 'Account 2',
      accountNumber: '8988 1234',
      balance: '\$12,000',
      branch: 'New York',
    ),
    AccountItemModel(
      title: 'Account 3',
      accountNumber: '1900 1234 2222',
      balance: '\$230,000',
      branch: 'New York',
    ),
  ];

  final List<CardItemModel> _cards = const [
    CardItemModel(
      holderName: 'John Smith',
      type: 'Amazon Platinium',
      number: '4756  ••••  ••••  9018',
      amount: '\$3.469.52',
      scheme: 'VISA',
      theme: BankCardTheme.blue,
      maskedCardNumber: '**** **** 9018',
      validFrom: '10/15',
      goodThru: '10/20',
      availableBalance: '\$10,000',
    ),
    CardItemModel(
      holderName: 'Mohanad Zaqout',
      type: 'Amazon Platinium',
      number: '4756  ••••  ••••  9018',
      amount: '\$5.469.52',
      scheme: '',
      theme: BankCardTheme.orange,
      maskedCardNumber: '**** **** 9018',
      validFrom: '11/16',
      goodThru: '11/21',
      availableBalance: '\$8,500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final contentMaxWidth = constraints.maxWidth > 500
                ? 460.0
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ScreenHeader(
                        title: 'Account and card',
                        onBackTap: () => Navigator.of(context).maybePop(),
                      ),
                      const SizedBox(height: 20),
                      AccountCardSegmentedControl(
                        isCardSelected: isCardTab,
                        onAccountTap: () {
                          if (isCardTab) {
                            setState(() => isCardTab = false);
                          }
                        },
                        onCardTap: () {
                          if (!isCardTab) {
                            setState(() => isCardTab = true);
                          }
                        },
                      ),
                      const SizedBox(height: 22),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: isCardTab
                              ? _CardsTabContent(
                                  key: const ValueKey('cards_tab'),
                                  cards: _cards,
                                )
                              : _AccountsTabContent(
                                  key: const ValueKey('accounts_tab'),
                                  accounts: _accounts,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AccountsTabContent extends StatelessWidget {
  const _AccountsTabContent({super.key, required this.accounts});

  final List<AccountItemModel> accounts;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final avatarSize = constraints.maxWidth < 360 ? 64.0 : 72.0;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileHeader(
                avatarSize: avatarSize,
                name: 'Push Puttichai',
                imageProvider: const AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 22),
              ...List.generate(
                accounts.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: index == accounts.length - 1 ? 0 : 14,
                  ),
                  child: AccountInfoCard(item: accounts[index]),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _CardsTabContent extends StatelessWidget {
  const _CardsTabContent({super.key, required this.cards});

  final List<CardItemModel> cards;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ...List.generate(
            cards.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                bottom: index == cards.length - 1 ? 0 : 18,
              ),
              child: BankCardWidget(
                item: cards[index],
                onTap: () {
                  context.pushNamed('card-detail', extra: cards[index]);
                },
              ),
            ),
          ),
          const SizedBox(height: 26),
          PrimaryActionButton(text: 'Add card', onTap: () {}),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
