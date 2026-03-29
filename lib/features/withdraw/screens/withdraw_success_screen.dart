import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:banking_app/features/home/widgets/screen_header.dart';

class WithdrawSuccessScreen extends StatelessWidget {
  const WithdrawSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final contentMaxWidth = constraints.maxWidth > 500
                ? 460.0
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ScreenHeader(
                        
                        title: 'Withdraw',
                        onBackTap: () => context.pop(),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              'assets/confirm.png',
                              height: constraints.maxHeight * 0.24,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 28),
                            const Text(
                              'Successful withdrawal!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4338D1),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'You have successfully withdraw money!\nPlease check the balance in the card\nmanagement section.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4A4A55),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () => context.pop(),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xff4338D1),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),

                                child: const Text(
                                  'confirm',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
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
