import 'package:banking_app/features/transaction_report/models/report_chart_item_model.dart';
import 'package:flutter/material.dart';

class ReportBarChart extends StatelessWidget {
  final List<ReportChartItemModel> items;

  const ReportBarChart({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(items.length, (index) {
          final item = items[index];

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 88,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 5,
                        height: item.incomeHeight.clamp(12, 52),
                        decoration: BoxDecoration(
                          color: const Color(0xff4338D8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        width: 5,
                        height: item.expenseHeight.clamp(8, 30),
                        decoration: BoxDecoration(
                          color: const Color(0xffFF4D7E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item.month,
                  style: TextStyle(
                    color: item.isSelected
                        ? const Color(0xff4338D8)
                        : const Color(0xffB4B4B4),
                    fontSize: 11,
                    fontWeight:
                        item.isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}