import 'package:banking_app/features/pay-bill/providers/pay_bill_provider.dart';
import 'package:banking_app/features/pay-bill/widgets/internet_bill_summary_card.dart';
import 'package:banking_app/features/pay-bill/widgets/pay_bill_labeled_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:banking_app/features/home/widgets/screen_header.dart';

class InternetBillDetailsScreen extends ConsumerStatefulWidget {
  const InternetBillDetailsScreen({super.key});

  @override
  ConsumerState<InternetBillDetailsScreen> createState() =>
      _InternetBillDetailsScreenState();
}

class _InternetBillDetailsScreenState
    extends ConsumerState<InternetBillDetailsScreen> {
  late final TextEditingController _accountController;
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(payBillProvider);
    final bill = state.internetBill;

    final accountText = state.selectedAccount?.accountNumber ?? '';

    if (_accountController.text != accountText) {
      _accountController.value = TextEditingValue(
        text: accountText,
        selection: TextSelection.collapsed(offset: accountText.length),
      );
    }

    if (_otpController.text != state.otp) {
      _otpController.value = TextEditingValue(
        text: state.otp,
        selection: TextSelection.collapsed(offset: state.otp.length),
      );
    }

    if (bill == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F5F8),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            final contentMaxWidth = constraints.maxWidth > 500
                ? 460.0
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    8,
                    horizontalPadding,
                    bottomInset > 0 ? bottomInset + 16 : 16,
                  ),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        ScreenHeader(
                          title: 'Internet bill',
                          onBackTap: () => context.pop(),
                        ),
                        const SizedBox(height: 18),
                        InternetBillSummaryCard(
                          bill: bill,
                          showTopImage: true,
                          imagePath: 'assets/internet-bill.png',
                          dateRange: '01/10/2019 - 01/11/2019',
                        ),
                        const SizedBox(height: 20),
                        PayBillLabeledField(
                          label: '',
                          controller: _accountController,
                          hintText: 'Choose account / card',
                          readOnly: true,
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF9999A3),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Get OTP to verify transaction',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9999A3),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: PayBillLabeledField(
                                label: '',
                                controller: _otpController,
                                hintText: 'OTP',
                                onChanged: ref
                                    .read(payBillProvider.notifier)
                                    .updateOtp,
                                suffixIcon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: Color(0xFF9999A3),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 112,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () async {
                                        ref
                                            .read(payBillProvider.notifier)
                                            .selectAccount(
                                              state.accounts.first,
                                            );
                                        await ref
                                            .read(payBillProvider.notifier)
                                            .getOtp();
                                      },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF4338D1),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Get OTP',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 34),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: state.canPayInternetBill
                                ? () async {
                                    final ok = await ref
                                        .read(payBillProvider.notifier)
                                        .submitInternetBillPayment();

                                    if (ok && context.mounted) {
                                      context.pushNamed(
                                        'internet-bill-success',
                                      );
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xFF4338D1),
                              disabledBackgroundColor: const Color(0xFFE5E4F4),
                              foregroundColor: Colors.white,
                              disabledForegroundColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Pay the bill',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
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
          },
        ),
      ),
    );
  }
}
