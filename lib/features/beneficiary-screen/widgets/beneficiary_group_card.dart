import 'package:banking_app/features/beneficiary-screen/models/beneficiary_model.dart';
import 'package:banking_app/features/beneficiary-screen/widgets/beneficiary_item.dart';
import 'package:flutter/material.dart';

class BeneficiaryGroupCard extends StatelessWidget {
  final String title;
  final List<BeneficiaryModel> items;

  const BeneficiaryGroupCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF9B9BA5),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: List.generate(
              items.length,
              (index) => BeneficiaryItem(
                item: items[index],
                showDivider: index != items.length - 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}