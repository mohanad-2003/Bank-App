import 'package:banking_app/features/home/models/home_action_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionCard extends StatelessWidget {
  final HomeActionItem item;

  const ActionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) { 
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        context.push(item.route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: item.color, size: 30),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xff8C8C8C),
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
