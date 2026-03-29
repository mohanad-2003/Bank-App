import 'package:flutter/material.dart';

class SettingsMenuTile extends StatelessWidget {
  final String title;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool showArrow;

  const SettingsMenuTile({
    super.key,
    required this.title,
    this.trailingText,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xff3A3A3A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText!,
                style: const TextStyle(
                  color: Color(0xff8C8C8C),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (showArrow)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xffB3B3B3),
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}