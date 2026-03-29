import 'package:banking_app/features/transfer/providers/transfer_provider.dart';
import 'package:banking_app/features/transfer/widgets/confirm_info_field.dart';
import 'package:banking_app/features/transfer/widgets/otp_input_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransferConfirmScreen extends ConsumerStatefulWidget {
  const TransferConfirmScreen({super.key});

  @override
  ConsumerState<TransferConfirmScreen> createState() =>
      _TransferConfirmScreenState();
}

class _TransferConfirmScreenState extends ConsumerState<TransferConfirmScreen> {
  late final TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transferProvider);
    final notifier = ref.read(transferProvider.notifier);

    if (otpController.text != state.otp) {
      otpController.text = state.otp;
      otpController.selection = TextSelection.fromPosition(
        TextPosition(offset: otpController.text.length),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (context.canPop()) context.pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2D2D2D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Confirm transaction information',
                    style: TextStyle(
                      color: Color(0xffB0B0B0),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ConfirmInfoField(
                    label: 'From',
                    value: notifier.maskedFromAccount(),
                  ),
                  const SizedBox(height: 10),
                  ConfirmInfoField(
                    label: 'To',
                    value: state.name,
                  ),
                  const SizedBox(height: 10),
                  if (state.isOtherBank) ...[
                    ConfirmInfoField(
                      label: 'Beneficiary bank',
                      value: state.selectedBank,
                    ),
                    const SizedBox(height: 10),
                  ],
                  ConfirmInfoField(
                    label: 'Card number',
                    value: state.cardNumber,
                  ),
                  const SizedBox(height: 10),
                  ConfirmInfoField(
                    label: 'Transaction fee',
                    value: notifier.transactionFee(),
                  ),
                  const SizedBox(height: 10),
                  ConfirmInfoField(
                    label: state.isOtherBank ? 'Note' : 'Content',
                    value: state.content,
                  ),
                  const SizedBox(height: 10),
                  ConfirmInfoField(
                    label: 'Amount',
                    value: '\$${state.amount}',
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Get OTP to verify transaction',
                    style: TextStyle(
                      color: Color(0xffB0B0B0),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OtpInputRow(
                    controller: otpController,
                    onChanged: notifier.updateOtp,
                    onGetOtp: notifier.requestOtp,
                    otpRequested: state.otpRequested,
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: InkWell(
                      onTap: () {
                        notifier.enableBiometric();
                      },
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/finger.png',
                        width: 52,
                        height: 52,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.fingerprint,
                            size: 52,
                            color: Color(0xff7B74E8),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: state.canFinalConfirm
                          ? () {
                              context.go('/transfer-success');
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: state.canFinalConfirm
                            ? const Color(0xff4338D8)
                            : const Color(0xffE8E6F7),
                        disabledBackgroundColor: const Color(0xffE8E6F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
            );
          },
        ),
      ),
    );
  }
}