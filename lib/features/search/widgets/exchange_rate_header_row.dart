import 'package:flutter/material.dart';

class ExchangeRateHeaderRow extends StatelessWidget {
  const ExchangeRateHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
      color: Color(0xffA5A5A5),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              'Country',
              style: headerStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Buy',
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Sell',
              textAlign: TextAlign.right,
              style: headerStyle,
            ),
          ),
        ],
      ),
    );
  }
}