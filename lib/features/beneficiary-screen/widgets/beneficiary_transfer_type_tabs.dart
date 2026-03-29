import 'package:banking_app/features/beneficiary-screen/models/beneficiary_model.dart';
import 'package:flutter/material.dart';

class BeneficiaryTransferTypeTabs extends StatelessWidget {
  final BeneficiaryTransferType selectedType;
  final ValueChanged<BeneficiaryTransferType> onChanged;

  const BeneficiaryTransferTypeTabs({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TransferTypeCard(
            label: 'Transfer via\ncard number',
            icon: Icons.credit_card_rounded,
            selected: selectedType == BeneficiaryTransferType.cardNumber,
            onTap: () => onChanged(BeneficiaryTransferType.cardNumber),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TransferTypeCard(
            label: 'Transfer to\nthe same bank',
            icon: Icons.person_rounded,
            selected: selectedType == BeneficiaryTransferType.sameBank,
            onTap: () => onChanged(BeneficiaryTransferType.sameBank),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TransferTypeCard(
            label: 'Transfer to\nanother bank',
            icon: Icons.account_balance_rounded,
            selected: selectedType == BeneficiaryTransferType.anotherBank,
            onTap: () => onChanged(BeneficiaryTransferType.anotherBank),
          ),
        ),
      ],
    );
  }
}

class _TransferTypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TransferTypeCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = selected ? const Color(0xFFF8B12D) : const Color(0xFFF1F1F4);
    final foreground = selected ? Colors.white : const Color(0xFFD1D1D8);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foreground, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}