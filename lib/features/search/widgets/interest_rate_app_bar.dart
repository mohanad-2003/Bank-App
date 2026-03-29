import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InterestRateAppBar extends StatelessWidget {
  const InterestRateAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (context.canPop()) {
              context.pop();
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xff454545),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Interest rate',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Color(0xff2D2D2D),
            ),
          ),
        ),
      ],
    );
  }
}