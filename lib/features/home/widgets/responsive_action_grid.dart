import 'package:banking_app/features/home/models/home_action_item.dart';
import 'package:banking_app/features/home/widgets/action_card.dart';
import 'package:flutter/material.dart';

class ResponsiveActionsGrid extends StatelessWidget {
  final List<HomeActionItem> actions;

  const ResponsiveActionsGrid({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 130,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (context, index) {
        return ActionCard(item: actions[index]);
      },
    );
  }
}