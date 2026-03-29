import 'package:flutter/material.dart';

class InterestRateHeaderRow extends StatelessWidget {
  const InterestRateHeaderRow({super.key});

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
              'Interest kind',
              style: headerStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Deposit',
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Rate',
              textAlign: TextAlign.right,
              style: headerStyle,
            ),
          ),
        ],
      ),
    );
  }
}