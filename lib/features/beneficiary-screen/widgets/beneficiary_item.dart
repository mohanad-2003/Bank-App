import 'package:banking_app/features/beneficiary-screen/models/beneficiary_model.dart';
import 'package:flutter/material.dart';

class BeneficiaryItem extends StatelessWidget {
  final BeneficiaryModel item;
  final bool showDivider;

  const BeneficiaryItem({
    super.key,
    required this.item,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(item.image),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.number,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFA1A1AA),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 14),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF0F0F4),
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}