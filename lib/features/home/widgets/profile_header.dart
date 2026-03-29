import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.avatarSize,
    required this.name,
    this.imageProvider,
  });

  final double avatarSize;
  final String name;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFE9E9EF),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
            image: imageProvider != null
                ? DecorationImage(
                    image: imageProvider!,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageProvider == null
              ? const Icon(
                  Icons.person_rounded,
                  size: 32,
                  color: Color(0xFF8B8B98),
                )
              : null,
        ),
        const SizedBox(height: 12),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4338D1),
          ),
        ),
      ],
    );
  }
}