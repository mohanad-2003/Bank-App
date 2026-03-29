import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final String userName;
  final String imagePath;

  const SettingsHeader({
    super.key,
    required this.userName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(imagePath),
          onBackgroundImageError: (_, _) {},
          child: imagePath.isEmpty ? const Icon(Icons.person) : null,
        ),
        const SizedBox(height: 10),
        Text(
          userName,
          style: const TextStyle(
            color: Color(0xff4338D8),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}