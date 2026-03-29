import 'package:flutter/material.dart';

class ExchangeRateInfo extends StatelessWidget {
  final String rateText;
  final bool visible;

  const ExchangeRateInfo({
    super.key,
    required this.rateText,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Row(
      children: [
        const Text(
          'Currency rate',
          style: TextStyle(
            color: Color(0xff4A3FE2),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          rateText,
          style: const TextStyle(
            color: Color(0xff5B5B5B),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}