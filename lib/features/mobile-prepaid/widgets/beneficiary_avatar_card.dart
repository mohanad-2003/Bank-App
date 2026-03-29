import 'package:banking_app/features/mobile-prepaid/models/beneficiary_prepaid_model.dart';
import 'package:flutter/material.dart';

class BeneficiaryAvatarCard extends StatelessWidget {
  const BeneficiaryAvatarCard({
    super.key,
    required this.beneficiary,
    required this.isSelected,
    required this.onTap,
  });

  final BeneficiaryPrepaidModel beneficiary;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isSelected ? const Color(0xFF4338D1) : const Color(0xFFF7F7FB);
    final textColor =
        isSelected ? Colors.white : const Color(0xFF333333);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 92,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(beneficiary.imagePath),
            ),
            const SizedBox(height: 10),
            Text(
              beneficiary.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}