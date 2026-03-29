import 'package:banking_app/features/home/models/bank_card_model.dart';
import 'package:banking_app/features/home/models/home_action_item.dart';
import 'package:banking_app/features/home/widgets/bank_card_widgets.dart';
import 'package:banking_app/features/home/widgets/responsive_action_grid.dart';
import 'package:flutter/material.dart';

class HomeContentCard extends StatelessWidget {
  final double horizontalPadding;
  final BankCardModel card;
  final List<HomeActionItem> actions;

  const HomeContentCard({
    super.key,
    required this.horizontalPadding,
    required this.card,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        22,
        horizontalPadding,
        24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      child: Column(
        children: [
          BankCardWidget(card: card),
          const SizedBox(height: 26),
          ResponsiveActionsGrid(actions: actions),
        ],
      ),
    );
  }
}
