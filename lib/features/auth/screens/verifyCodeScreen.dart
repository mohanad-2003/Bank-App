import 'package:banking_app/features/data/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({
    super.key,
    required this.verificationId,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController codeController = TextEditingController();

  bool isEnabled = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    codeController.addListener(_checkField);
  }

  void _checkField() {
    setState(() {
      isEnabled = codeController.text.trim().isNotEmpty;
    });
  }

  Future<void> verifyCode() async {
    try {
      setState(() => isLoading = true);

      await _authService.verifyOtpCode(
        verificationId: widget.verificationId,
        smsCode: codeController.text,
      );

      if (!mounted) return;
      context.go('/change-password');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid verification code')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    codeController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xff2196F3),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Type a code',
                      style: TextStyle(
                        color: Color(0xff9A9A9A),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: CodeInputField(controller: codeController),
                        ),
                        const SizedBox(width: 10),
                        ResendButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Go back and send code again'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'We texted you a code to verify your\nphone number',
                      style: TextStyle(
                        color: Color(0xff6A6A6A),
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "This code will expire after a while.\nIf you don't get a message, resend it.",
                      style: TextStyle(
                        color: Color(0xff6A6A6A),
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 22),
                    ChangePasswordButton(
                      isEnabled: isEnabled && !isLoading,
                      text: isLoading ? 'Verifying...' : 'Change password',
                      onPressed: isEnabled && !isLoading ? verifyCode : null,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.pop(),
                child: const Text(
                  'Change your phone number',
                  style: TextStyle(
                    color: Color(0xff3B2CCB),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class CodeInputField extends StatelessWidget {
  final TextEditingController controller;

  const CodeInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffDADADA)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Code',
          hintStyle: TextStyle(color: Color(0xffC4C4C4), fontSize: 16),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}

class ResendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResendButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff3B2CCB),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Resend',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ChangePasswordButton extends StatelessWidget {
  final bool isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const ChangePasswordButton({
    super.key,
    required this.isEnabled,
    required this.text,
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
              ? const Color(0xff3B2CCB)
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