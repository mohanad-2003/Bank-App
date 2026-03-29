import 'package:banking_app/features/transaction_report/models/transaction_item_model.dart';
import 'package:flutter/material.dart';

class TransactionHistoryTile extends StatelessWidget {
  final TransactionItemModel item;
  final bool showSectionTitle;

  const TransactionHistoryTile({
    super.key,
    required this.item,
    required this.showSectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showSectionTitle)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              item.sectionTitle,
              style: const TextStyle(
                color: Color(0xff9B9B9B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: item.iconBgColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(item.icon, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff333333),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (item.sectionTitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.sectionTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              item.amount,
              style: TextStyle(
                color: item.isIncome
                    ? const Color(0xff4338D8)
                    : const Color(0xffFF4D7E),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
