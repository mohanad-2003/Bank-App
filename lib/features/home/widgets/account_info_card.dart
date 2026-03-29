import 'package:banking_app/features/home/models/account_item_model.dart';
import 'package:flutter/material.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({
    super.key,
    required this.item,
  });

  final AccountItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8FC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 300;

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AccountCardTopRow(item: item, forceColumn: true),
                const SizedBox(height: 12),
                _AccountCardBottomSection(item: item, forceColumn: true),
              ],
            );
          }

          return Column(
            children: [
              _AccountCardTopRow(item: item),
              const SizedBox(height: 12),
              _AccountCardBottomSection(item: item),
            ],
          );
        },
      ),
    );
  }
}

class _AccountCardTopRow extends StatelessWidget {
  const _AccountCardTopRow({
    required this.item,
    this.forceColumn = false,
  });

  final AccountItemModel item;
  final bool forceColumn;

  @override
  Widget build(BuildContext context) {
    if (forceColumn) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.accountNumber,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3B3B3B),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2B2B2B),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            item.accountNumber,
            maxLines: 1,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3B3B3B),
            ),
          ),
        ),
      ],
    );
  }
}

class _AccountCardBottomSection extends StatelessWidget {
  const _AccountCardBottomSection({
    required this.item,
    this.forceColumn = false,
  });

  final AccountItemModel item;
  final bool forceColumn;

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xFFB0AFB8),
    );

    const valueStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Color(0xFF4338D1),
    );

    if (forceColumn) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Available balance', style: labelStyle),
          const SizedBox(height: 4),
          Text(
            item.balance,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: valueStyle,
          ),
          const SizedBox(height: 10),
          const Text('Branch', style: labelStyle),
          const SizedBox(height: 4),
          Text(
            item.branch,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: valueStyle,
          ),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Available balance',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                item.balance,
                maxLines: 1,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: valueStyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Branch',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                item.branch,
                maxLines: 1,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: valueStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}