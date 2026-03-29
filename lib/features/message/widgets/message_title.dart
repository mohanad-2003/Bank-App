import 'package:banking_app/features/message/models/message_preview_model.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final MessagePreviewModel item;
  final VoidCallback onTap;
  final bool isSelected;

  const MessageTile({
    super.key,
    required this.item,
    required this.onTap,
    this.isSelected = false,
  });

  Color _iconBg() {
    switch (item.iconType) {
      case 'bank':
        return const Color(0xff4A3FE2);
      case 'account':
        return const Color(0xffFF4D7E);
      case 'alert':
        return const Color(0xff1E90FF);
      case 'paypal':
        return const Color(0xffF5A623);
      case 'withdraw':
        return const Color(0xff52D5BA);
      default:
        return const Color(0xffD9D9D9);
    }
  }

  IconData _iconData() {
    switch (item.iconType) {
      case 'bank':
        return Icons.account_balance_rounded;
      case 'account':
        return Icons.person_rounded;
      case 'alert':
        return Icons.call_received_rounded;
      case 'paypal':
        return Icons.paypal_rounded;
      case 'withdraw':
        return Icons.account_balance_wallet_rounded;
      default:
        return Icons.message_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: const Color(0xff7A4DFF), width: 2)
              : null,
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _iconBg(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _iconData(),
                color: Colors.white,
                size: 20,
              ),
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
                      color: Color(0xff2E2E2E),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff9B9B9B),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              item.dateText,
              style: const TextStyle(
                color: Color(0xffB0B0B0),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}