import 'package:banking_app/features/mobile-prepaid/providers/mobile_prepaid_provider.dart';
import 'package:banking_app/features/mobile-prepaid/widgets/prepaid_labeled_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:banking_app/features/home/widgets/screen_header.dart';

class MobilePrepaidConfirmScreen extends ConsumerStatefulWidget {
  const MobilePrepaidConfirmScreen({super.key});

  @override
  ConsumerState<MobilePrepaidConfirmScreen> createState() =>
      _MobilePrepaidConfirmScreenState();
}

class _MobilePrepaidConfirmScreenState
    extends ConsumerState<MobilePrepaidConfirmScreen> {
  late final TextEditingController _fromController;
  late final TextEditingController _toController;
  late final TextEditingController _amountController;
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    _amountController = TextEditingController();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _amountController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mobilePrepaidProvider);

    final fromText = state.selectedAccount == null
        ? ''
        : '**** **** ${state.selectedAccount!.accountNumber.split(' ').last}';

    final amountText = state.selectedAmount == null
        ? ''
        : '\$${state.selectedAmount}';

    if (_fromController.text != fromText) {
      _fromController.text = fromText;
    }
    if (_toController.text != state.phoneNumber) {
      _toController.text = state.phoneNumber;
    }
    if (_amountController.text != amountText) {
      _amountController.text = amountText;
    }
    if (_otpController.text != state.otp) {
      _otpController.value = TextEditingValue(
        text: state.otp,
        selection: TextSelection.collapsed(offset: state.otp.length),
      );
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

            return ConstrainedBox(
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
                        title: 'Confirm',
                        onBackTap: () => context.pop(),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Confirm transaction information',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9999A3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 14),
                      PrepaidLabeledField(
                        label: 'From',
                        controller: _fromController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 14),
                      PrepaidLabeledField(
                        label: 'To',
                        controller: _toController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 14),
                      PrepaidLabeledField(
                        label: 'Amount',
                        controller: _amountController,
                        readOnly: true,
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
                            child: PrepaidLabeledField(
                              label: '',
                              controller: _otpController,
                              hintText: 'OTP',
                              onChanged: ref
                                  .read(mobilePrepaidProvider.notifier)
                                  .updateOtp,
                              suffix: const Icon(
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
                              onPressed: state.isSubmitting
                                  ? null
                                  : () async {
                                      await ref
                                          .read(mobilePrepaidProvider.notifier)
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
                      const SizedBox(height: 42),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: state.canSubmitPayment
                              ? () async {
                                  final ok = await ref
                                      .read(mobilePrepaidProvider.notifier)
                                      .submitPayment();

                                  if (ok && context.mounted) {
                                    context.pushNamed('mobile-prepaid-success');
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
                            'Confirm',
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
            );
          },
        ),
      ),
    );
  }
}
