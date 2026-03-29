import 'package:flutter/material.dart';

class CardDetailRow extends StatelessWidget {
  const CardDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.isHighlighted = false,
  });

  final String title;
  final String value;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontSize: 15,
      color: Color(0xFF9A9AA3),
      fontWeight: FontWeight.w500,
    );

    final valueStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: isHighlighted ? const Color(0xFF4338D1) : const Color(0xFF2B2B2B),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: valueStyle,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFEDEDF2),
        ),
      ],
    );
  }
}