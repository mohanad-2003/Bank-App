import 'package:banking_app/features/home/widgets/notification_bell.dart';
import 'package:flutter/material.dart';

class HomeTopHeader extends StatelessWidget {
  final double horizontalPadding;
  final String userName;
  final int notificationCount;

  const HomeTopHeader({
    super.key,
    required this.horizontalPadding,
    required this.userName,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        12,
        horizontalPadding,
        90,
      ),
      decoration: const BoxDecoration(
        color: Color(0xff3B2CCB),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final avatarSize = constraints.maxWidth * 0.14;

          return Row(
            children: [
              CircleAvatar(
                radius: avatarSize / 2,
                backgroundImage: const AssetImage('assets/profile.png'),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Hi, $userName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              NotificationBell(count: notificationCount),
            ],
          );
        },
      ),
    );
  }
}