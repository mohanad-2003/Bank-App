import 'package:banking_app/features/search/models/interest_rate_item_model.dart';
import 'package:flutter/material.dart';

class InterestRateRowItem extends StatelessWidget {
  final InterestRateItemModel item;

  const InterestRateRowItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              item.interestKind,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.deposit,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff4A4A4A),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.rate,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xff5A4FF3),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}