import 'package:flutter/material.dart';

class OtpInputRow extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onGetOtp;
  final bool otpRequested;

  const OtpInputRow({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onGetOtp,
    required this.otpRequested,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = controller.text.trim().length >= 4;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'OTP',
                hintStyle: const TextStyle(
                  color: Color(0xffC2C2C2),
                  fontSize: 12,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xff4A3FE2)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 84,
          height: 40,
          child: ElevatedButton(
            onPressed: onGetOtp,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor:
                  otpRequested ? const Color(0xff4338D8) : const Color(0xff4338D8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Get OTP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}