import 'package:banking_app/features/pay-bill/models/payment_history_item_model.dart';
import 'package:flutter/material.dart';

class PaymentHistoryItemCard extends StatelessWidget {
  const PaymentHistoryItemCard({
    super.key,
    required this.item,
  });

  final PaymentHistoryItemModel item;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        item.isSuccessful ? const Color(0xFF4338D1) : const Color(0xFFFF4D6D);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.month,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              Text(
                item.date,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9C9CA6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9C9CA6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.status,
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Text(
                'Amount',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9C9CA6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.amount,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4338D1),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (item.company != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Company',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9C9CA6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.company!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4338D1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}