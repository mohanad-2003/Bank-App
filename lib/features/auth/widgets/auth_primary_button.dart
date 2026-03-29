import 'package:flutter/material.dart';

class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double height;
  final double borderRadius;
  final Color enabledColor;
  final Color disabledColor;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
    this.height = 56,
    this.borderRadius = 18,
    this.enabledColor = const Color(0xff3629B7),
    this.disabledColor = const Color(0xffC9C9C9),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? enabledColor : disabledColor,
          disabledBackgroundColor: disabledColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}