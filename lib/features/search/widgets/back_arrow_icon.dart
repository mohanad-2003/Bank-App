import 'package:flutter/material.dart';

class BackArrowIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const BackArrowIcon({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.all(4),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 22,
          color: Color(0xff4A4A4A),
        ),
      ),
    );
  }
}