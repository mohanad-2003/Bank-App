import 'package:banking_app/features/auth/providers/signin_provider.dart';
import 'package:banking_app/features/auth/widgets/auth_primary_button.dart';
import 'package:banking_app/features/auth/widgets/auth_text_field.dart';
import 'package:banking_app/features/auth/widgets/lock_illustration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _checkFields() {
    ref.read(signinProvider.notifier).updateButtonState(
          email: emailController.text,
          password: passwordController.text,
        );
  }

  Future<void> _signInUser() async {
    final message = await ref.read(signinProvider.notifier).signIn(
          email: emailController.text,
          password: passwordController.text,
        );

    if (!mounted) return;

    if (message == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully')),
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
    emailController.addListener(_checkFields);
    passwordController.addListener(_checkFields);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signinProvider);

    return Scaffold(
      backgroundColor: const Color(0xff3629B7),
      appBar: AppBar(
        backgroundColor: const Color(0xff3629B7),
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
          'Sign in',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  decoration: const BoxDecoration(
                    color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Color(0xff3629B7),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Hello there, sign in to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Center(child: LockIllustration()),
                      const SizedBox(height: 30),
                      AuthTextField(
                        hint: "Email",
                        controller: emailController,
                        borderRadius: 30,
                        height: 55,
                        borderColor: const Color(0xffCFCFCF),
                        hintColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        hint: "Password",
                        isPassword: true,
                        controller: passwordController,
                        borderRadius: 30,
                        height: 55,
                        borderColor: const Color(0xffCFCFCF),
                        hintColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => context.push('/forgot-password'),
                          child: const Text(
                            "Forgot your password ?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AuthPrimaryButton(
                        text: state.isLoading ? 'Loading...' : 'Sign in',
                        isEnabled: state.isEnabled && !state.isLoading,
                        onPressed: state.isEnabled && !state.isLoading
                            ? _signInUser
                            : null,
                        height: 58,
                        borderRadius: 18,
                        enabledColor: const Color(0xff3629B7),
                        disabledColor: const Color(0xffC9C9C9),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Image.asset(
                          'assets/finger.png',
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.push('/signup'),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3629B7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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