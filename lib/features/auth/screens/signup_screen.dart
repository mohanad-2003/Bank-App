import 'package:banking_app/features/auth/providers/signup_provider.dart';
import 'package:banking_app/features/auth/widgets/auth_primary_button.dart';
import 'package:banking_app/features/auth/widgets/auth_text_field.dart';
import 'package:banking_app/features/auth/widgets/signup_illustration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _updateButtonState() {
    ref.read(signupProvider.notifier).updateButtonState(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
  }

  Future<void> _signUpUser() async {
    final message = await ref.read(signupProvider.notifier).signUp(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

    if (!mounted) return;

    if (message == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateButtonState);
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signupProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff3B2CCB),
      appBar: AppBar(
        backgroundColor: const Color(0xff3B2CCB),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(26, 24, 26, 24),
                  decoration: const BoxDecoration(
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(34),
                      topRight: Radius.circular(34),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome to us,',
                        style: TextStyle(
                          color: Color(0xff3B2CCB),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Hello there, create New account',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 26),
                      const Center(child: SignupIllustration()),
                      const SizedBox(height: 28),
                      AuthTextField(
                        controller: nameController,
                        hint: 'Name',
                        borderRadius: 16,
                        height: 54,
                        borderColor: const Color(0xffCFCFCF),
                        hintColor: const Color(0xffB8B8B8),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      const SizedBox(height: 18),
                      AuthTextField(
                        controller: emailController,
                        hint: 'Email',
                        borderRadius: 16,
                        height: 54,
                        borderColor: const Color(0xffCFCFCF),
                        hintColor: const Color(0xffB8B8B8),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      const SizedBox(height: 18),
                      AuthTextField(
                        controller: passwordController,
                        hint: 'Password',
                        isPassword: true,
                        borderRadius: 16,
                        height: 54,
                        borderColor: const Color(0xffCFCFCF),
                        hintColor: const Color(0xffB8B8B8),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xffB8B8B8),
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ref.read(signupProvider.notifier).toggleAgreeTerms(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 2),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: state.agreeTerms
                                    ? const Color(0xff3B2CCB)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xffC8C8C8),
                                  width: 1.2,
                                ),
                              ),
                              child: state.agreeTerms
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'By creating an account your agree to our ',
                                  ),
                                  TextSpan(
                                    text: 'Term and Conditions',
                                    style: TextStyle(
                                      color: Color(0xff3B2CCB),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      AuthPrimaryButton(
                        text: state.isLoading ? 'Loading...' : 'Sign up',
                        isEnabled: state.isButtonEnabled && !state.isLoading,
                        onPressed: state.isButtonEnabled && !state.isLoading
                            ? _signUpUser
                            : null,
                        height: 54,
                        borderRadius: 16,
                        enabledColor: const Color(0xff3B2CCB),
                        disabledColor: const Color(0xffE7E3F4),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account? ',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color(0xff3B2CCB),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}