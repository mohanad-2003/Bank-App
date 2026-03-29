import 'package:flutter/material.dart';

class WithdrawAmountSelector extends StatelessWidget {
  const WithdrawAmountSelector({
    super.key,
    required this.selectedAmount,
    required this.onAmountSelected,
  });

  final int? selectedAmount;
  final ValueChanged<int> onAmountSelected;

  static const List<int> amounts = [10, 50, 100, 150, 200];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose amount',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9C9CA6),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          itemCount: amounts.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.55,
          ),
          itemBuilder: (context, index) {
            if (index == amounts.length) {
              final isSelected = selectedAmount == -1;

              return _AmountChip(
                label: 'Other',
                isSelected: isSelected,
                onTap: () => onAmountSelected(-1),
              );
            }

            final amount = amounts[index];
            final isSelected = selectedAmount == amount;

            return _AmountChip(
              label: '\$$amount',
              isSelected: isSelected,
              onTap: () => onAmountSelected(amount),
            );
          },
        ),
      ],
    );
  }
}

class _AmountChip extends StatelessWidget {
  const _AmountChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? const Color(0xFF4338D1) : Colors.white;
    final textColor = isSelected ? Colors.white : const Color(0xFF8E8E97);

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Center(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}