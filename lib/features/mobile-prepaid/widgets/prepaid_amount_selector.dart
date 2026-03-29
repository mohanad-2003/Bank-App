import 'package:flutter/material.dart';

class PrepaidAmountSelector extends StatelessWidget {
  const PrepaidAmountSelector({
    super.key,
    required this.selectedAmount,
    required this.onSelected,
  });

  final int? selectedAmount;
  final ValueChanged<int> onSelected;

  static const List<int> amounts = [10, 20, 30];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(amounts.length, (index) {
        final amount = amounts[index];
        final isSelected = selectedAmount == amount;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == amounts.length - 1 ? 0 : 12),
            child: InkWell(
              onTap: () => onSelected(amount),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF4338D1) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  '\$$amount',
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF8D8D97),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}