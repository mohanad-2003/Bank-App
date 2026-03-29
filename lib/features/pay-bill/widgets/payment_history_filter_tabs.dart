import 'package:banking_app/features/pay-bill/models/payment_history_item_model.dart';
import 'package:flutter/material.dart';

class PaymentHistoryFilterTabs extends StatelessWidget {
  const PaymentHistoryFilterTabs({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });
  final PaymentHistoryType selectedType;
  final ValueChanged<PaymentHistoryType> onChanged;
  @override
  Widget build(BuildContext context) {
    final tabs = <(String, PaymentHistoryType)>[
      ('Electric', PaymentHistoryType.electric),
      ('Water', PaymentHistoryType.water),
      ('Mobile', PaymentHistoryType.mobile),
      ('Interet', PaymentHistoryType.internet),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          final isSelected = tab.$2 == selectedType;
          return Padding(
            padding: EdgeInsets.only(right: index == tabs.length - 1 ? 0 : 10),
            child: InkWell(
              onTap: () => onChanged(tab.$2),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF4338D1)
                      : Color(0xFFF1F1F7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  tab.$1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF44444D),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
