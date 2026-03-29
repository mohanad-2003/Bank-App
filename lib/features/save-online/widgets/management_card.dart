import 'package:banking_app/features/save-online/models/save_account_model.dart';
import 'package:flutter/material.dart';

class ManagementCard extends StatelessWidget {
  final SaveAccountModel item;
  const ManagementCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Account',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(item.accountNumber),
            ],
          ),
          const SizedBox(height: 12),
          _row('From', item.fromDate),
          _row('To', item.toDate),
          _row('Time Deposit', item.duration),
          _row('Interested rate', item.interest, isHighlight: true),
        ],
      ),
    );
  }
}

Widget _row(String title, String value, {bool isHighlight = false}) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: isHighlight ? const Color(0xff4338D1) : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
