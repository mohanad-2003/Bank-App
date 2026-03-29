import 'package:banking_app/features/auth/widgets/auth_dot_circle.dart';
import 'package:flutter/material.dart';

class SignupIllustration extends StatelessWidget {
  const SignupIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 190,
      child: Stack(
        clipBehavior: Clip.none,
        children: const [
          Positioned(
            left: 62,
            top: 26,
            child: _MainSignupCircle(),
          ),
          AuthDotCircle(
            top: 10,
            left: 98,
            size: 10,
            color: Color(0xff3D37C9),
          ),
          AuthDotCircle(
            top: 34,
            right: 28,
            size: 24,
            color: Color(0xffFF4267),
          ),
          AuthDotCircle(
            left: 28,
            top: 72,
            size: 10,
            color: Color(0xff52D5BA),
          ),
          AuthDotCircle(
            left: 72,
            bottom: 22,
            size: 20,
            color: Color(0xffFFAF2A),
          ),
          AuthDotCircle(
            right: 46,
            bottom: 22,
            size: 10,
            color: Color(0xff0890FE),
          ),
        ],
      ),
    );
  }
}

class _MainSignupCircle extends StatelessWidget {
  const _MainSignupCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        color: Color(0xffE8E4FA),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 46,
          height: 84,
          decoration: BoxDecoration(
            color: const Color(0xff5C53C7),
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Image(
              image: AssetImage('assets/group.png'),
            ),
          ),
        ),
      ),
    );
  }
}