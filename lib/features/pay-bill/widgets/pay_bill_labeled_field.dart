import 'package:flutter/material.dart';

class PayBillLabeledField extends StatelessWidget {
  const PayBillLabeledField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.readOnly = false,
    this.onChanged,
    this.suffixIcon,
    this.keyboardType,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9999A3),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: 48,
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFB9B9C2),
                fontWeight: FontWeight.w500,
              ),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD9D9E2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF4338D1)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}