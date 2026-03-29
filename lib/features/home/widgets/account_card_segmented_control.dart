import 'package:flutter/material.dart';

class AccountCardSegmentedControl extends StatelessWidget {
  const AccountCardSegmentedControl({
    super.key,
    required this.isCardSelected,
    required this.onAccountTap,
    required this.onCardTap,
  });

  final bool isCardSelected;
  final VoidCallback onAccountTap;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF4338D1);
    const inactiveColor = Color(0xFFE9E8F1);

    return Row(
      children: [
        Expanded(
          child: _SegmentButton(
            text: 'Account',
            isSelected: !isCardSelected,
            selectedColor: activeColor,
            unselectedColor: inactiveColor,
            onTap: onAccountTap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SegmentButton(
            text: 'Card',
            isSelected: isCardSelected,
            selectedColor: activeColor,
            unselectedColor: inactiveColor,
            onTap: onCardTap,
          ),
        ),
      ],
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.text,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected ? selectedColor : unselectedColor;
    final textColor = isSelected ? Colors.white : const Color(0xFF333333);

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 46,
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}