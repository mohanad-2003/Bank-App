import 'package:banking_app/features/data/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController phoneController = TextEditingController();

  bool isEnabled = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_checkField);
  }

  void _checkField() {
    setState(() {
      isEnabled = phoneController.text.trim().isNotEmpty;
    });
  }

  Future<void> sendOtp() async {
    try {
      setState(() => isLoading = true);

      await _authService.verifyPhone(
        phoneNumber: phoneController.text,
        onCodeSent: (verificationId) {
          if (!mounted) return;
          context.push('/verify-code', extra: verificationId);
        },
        onFailed: (message) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
        onVerifiedAutomatically: () {
          if (!mounted) return;
          context.go('/change-password');
        },
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F6F6),
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff2F2F2F)),
        ),
        title: const Text(
          'Forgot password',
          style: TextStyle(
            color: Color(0xff2F2F2F),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Type your phone number',
                  style: TextStyle(
                    color: Color(0xff8D8D8D),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                PhoneNumberField(controller: phoneController),
                const SizedBox(height: 18),
                const Text(
                  'We texted you a code to verify your\nphone number',
                  style: TextStyle(
                    color: Color(0xff2F2F2F),
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 22),
                SendButton(
                  text: isLoading ? 'Sending...' : 'Send',
                  isEnabled: isEnabled && !isLoading,
                  onPressed: isEnabled && !isLoading ? sendOtp : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffE3E3E3)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          hintText: '+970597340712',
          hintStyle: TextStyle(color: Color(0xffC4C4C4), fontSize: 16),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const SendButton({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? const Color(0xff3629B7)
              : const Color(0xffECE9F8),
          disabledBackgroundColor: const Color(0xffECE9F8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
