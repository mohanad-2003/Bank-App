import 'package:banking_app/features/pay-bill/providers/pay_bill_provider.dart';
import 'package:banking_app/features/pay-bill/widgets/pay_bill_labeled_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:banking_app/features/home/widgets/screen_header.dart';

class InternetBillFormScreen extends ConsumerStatefulWidget {
  const InternetBillFormScreen({super.key});

  @override
  ConsumerState<InternetBillFormScreen> createState() =>
      _InternetBillFormScreenState();
}

class _InternetBillFormScreenState extends ConsumerState<InternetBillFormScreen> {
  late final TextEditingController _companyController;
  late final TextEditingController _billCodeController;

  @override
  void initState() {
    super.initState();
    _companyController = TextEditingController();
    _billCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _billCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(payBillProvider);

    if (_companyController.text != state.internetCompany) {
      _companyController.value = TextEditingValue(
        text: state.internetCompany,
        selection: TextSelection.collapsed(offset: state.internetCompany.length),
      );
    }

    if (_billCodeController.text != state.internetBillCode) {
      _billCodeController.value = TextEditingValue(
        text: state.internetBillCode,
        selection: TextSelection.collapsed(offset: state.internetBillCode.length),
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
            final contentMaxWidth =
                constraints.maxWidth > 500 ? 460.0 : double.infinity;

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
                          title: 'Pay the bill',
                          onBackTap: () => context.pop(),
                        ),
                        const SizedBox(height: 24),
                        PayBillLabeledField(
                          label: '',
                          controller: _companyController,
                          hintText: 'Choose company',
                          onChanged: ref
                              .read(payBillProvider.notifier)
                              .updateInternetCompany,
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF9999A3),
                          ),
                        ),
                        const SizedBox(height: 14),
                        PayBillLabeledField(
                          label: 'Type internet bill code',
                          controller: _billCodeController,
                          hintText: 'Bill code',
                          onChanged: ref
                              .read(payBillProvider.notifier)
                              .updateInternetBillCode,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Please enter the correct bill code to\ncheck information.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF9999A3),
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: state.canCheckInternetBill && !state.isLoading
                                ? () async {
                                    final ok = await ref
                                        .read(payBillProvider.notifier)
                                        .checkInternetBill();

                                    if (ok && context.mounted) {
                                      context.pushNamed('internet-bill-details');
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
                            child: state.isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.2,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Check',
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