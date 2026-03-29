import 'package:banking_app/features/transfer/providers/transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransferSuccessScreen extends ConsumerWidget {
  const TransferSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/confirm.png',
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.task_alt_rounded,
                      size: 110,
                      color: Color(0xff4A3FE2),
                    );
                  },
                ),
                const SizedBox(height: 26),
                const Text(
                  'Transfer successful!',
                  style: TextStyle(
                    color: Color(0xff4338D8),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color(0xff666666),
                      fontSize: 13,
                      height: 1.6,
                    ),
                    children: [
                      const TextSpan(
                        text: 'You have successfully transferred ',
                      ),
                      TextSpan(
                        text: '\$${state.amount} ',
                        style: const TextStyle(
                          color: Color(0xffFF4D7E),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'to ${state.name}!',
                        style: const TextStyle(
                          color: Color(0xffFF4D7E),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(transferProvider.notifier).resetVerification();
                      context.go('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xff4338D8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
