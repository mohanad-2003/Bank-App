import 'package:banking_app/features/auth/widgets/auth_dot_circle.dart';
import 'package:flutter/material.dart';

class LockIllustration extends StatelessWidget {
  const LockIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 220,
      child: Stack(
        clipBehavior: Clip.none,
        children: const [
          Positioned(
            left: 55,
            top: 28,
            child: _MainLockCircle(),
          ),
          AuthDotCircle(
            top: 12,
            left: 92,
            size: 10,
            color: Color(0xff3D37C9),
          ),
          AuthDotCircle(
            top: 42,
            right: 38,
            size: 24,
            color: Color(0xffFF4267),
          ),
          AuthDotCircle(
            left: 24,
            top: 78,
            size: 10,
            color: Color(0xff52D5BA),
          ),
          AuthDotCircle(
            left: 64,
            bottom: 38,
            size: 20,
            color: Color(0xffFFAF2A),
          ),
          AuthDotCircle(
            right: 56,
            bottom: 38,
            size: 10,
            color: Color(0xff0890FE),
          ),
        ],
      ),
    );
  }
}

class _MainLockCircle extends StatelessWidget {
  const _MainLockCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      height: 145,
      decoration: const BoxDecoration(
        color: Color(0xffE5E2FF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          'assets/lock.png',
          width: 78,
          height: 78,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}