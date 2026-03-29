import 'package:banking_app/features/transaction_report/models/report_chart_item_model.dart';
import 'package:banking_app/features/transaction_report/widgets/report_bar_chart.dart';
import 'package:flutter/material.dart';

class ReportBalanceCard extends StatelessWidget {
  final String balance;
  final List<ReportChartItemModel> chartItems;

  const ReportBalanceCard({
    super.key,
    required this.balance,
    required this.chartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Balance',
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                balance,
                style: const TextStyle(
                  color: Color(0xff4338D8),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'USD',
                  style: TextStyle(
                    color: Color(0xffB0B0B0),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          CustomPaint(
            painter: _DashedLinePainter(),
            child: const SizedBox(
              width: double.infinity,
              height: 1,
            ),
          ),
          const SizedBox(height: 12),
          ReportBarChart(items: chartItems),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    double startX = 0;

    final paint = Paint()
      ..color = const Color(0xffE5E5E5)
      ..strokeWidth = 1;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}