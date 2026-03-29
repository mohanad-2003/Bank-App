import 'package:banking_app/features/search/models/branch_item_model.dart';
import 'package:flutter/material.dart';

class BranchListTile extends StatelessWidget {
  final BranchItemModel item;

  const BranchListTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_rounded,
            color: Color(0xff4B3AC7),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff333333),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            item.distance,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff9B9B9B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}