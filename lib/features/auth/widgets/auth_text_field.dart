import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final double borderRadius;
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final Color borderColor;
  final Color hintColor;
  final Widget? suffixIcon;

  const AuthTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.borderRadius = 18,
    this.height = 55,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    this.borderColor = const Color(0xffCFCFCF),
    this.hintColor = const Color(0xffB8B8B8),
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: 16,
            ),
            border: InputBorder.none,
            contentPadding: contentPadding,
            suffixIcon: suffixIcon ??
                (isPassword
                    ? const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xffB8B8B8),
                        size: 26,
                      )
                    : null),
          ),
        ),
      ),
    );
  }
}