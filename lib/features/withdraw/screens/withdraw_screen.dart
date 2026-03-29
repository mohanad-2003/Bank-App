import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:banking_app/features/home/widgets/screen_header.dart';
import 'package:banking_app/features/withdraw/models/withdraw_account_model.dart';
import 'package:banking_app/features/withdraw/providers/withdraw_provider.dart';
import 'package:banking_app/features/withdraw/widgets/withdraw_account_selector_sheet.dart';
import 'package:banking_app/features/withdraw/widgets/withdraw_amount_selector.dart';
import 'package:banking_app/features/withdraw/widgets/withdraw_text_field.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  late final TextEditingController _accountController;
  late final TextEditingController _phoneController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
    _phoneController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _openAccountSelector(
    List<WithdrawAccountModel> accounts,
    String? selectedId,
  ) async {
    final selected = await showModalBottomSheet<WithdrawAccountModel>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => WithdrawAccountSelectorSheet(
        accounts: accounts,
        selectedAccountId: selectedId,
      ),
    );

    if (selected != null) {
      ref.read(withdrawProvider.notifier).selectAccount(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(withdrawProvider);

    final accountText = state.selectedAccount == null
        ? ''
        : 'VISA •••• •••• •••• ${state.selectedAccount!.accountNumber.split(' ').last}';

    if (_accountController.text != accountText) {
      _accountController.value = TextEditingValue(
        text: accountText,
        selection: TextSelection.collapsed(offset: accountText.length),
      );
    }

    if (_phoneController.text != state.phoneNumber) {
      _phoneController.value = TextEditingValue(
        text: state.phoneNumber,
        selection: TextSelection.collapsed(offset: state.phoneNumber.length),
      );
    }

    if (_amountController.text != state.manualAmount) {
      _amountController.value = TextEditingValue(
        text: state.manualAmount,
        selection: TextSelection.collapsed(offset: state.manualAmount.length),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F5F8),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final contentMaxWidth = constraints.maxWidth > 500
                ? 460.0
                : double.infinity;
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

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
                          title: 'Withdraw',
                          onBackTap: () => context.pop(),
                        ),
                        const SizedBox(height: 18),
                        Image.asset(
                          'assets/confirm.png',
                          height: constraints.maxHeight * 0.23,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        WithdrawTextField(
                          controller: _accountController,
                          hintText: 'Choose account/card',
                          readOnly: true,
                          onTap: () => _openAccountSelector(
                            state.accounts,
                            state.selectedAccount?.id,
                          ),
                          suffixIcon: Icons.keyboard_arrow_down_rounded,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: state.selectedAccount == null
                                ? const Color(0xFFB8B8C2)
                                : const Color(0xFF333333),
                          ),
                        ),
                        if (state.selectedAccount != null) ...[
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Available balance : ${state.selectedAccount!.availableBalance.toStringAsFixed(0)}\$',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4338D1),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        WithdrawTextField(
                          controller: _phoneController,
                          hintText: 'Phone number',
                          keyboardType: TextInputType.phone,
                          onChanged: ref
                              .read(withdrawProvider.notifier)
                              .updatePhoneNumber,
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose amount',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9C9CA6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (state.manualAmount.isEmpty) ...[
                          WithdrawAmountSelector(
                            selectedAmount: state.selectedPresetAmount,
                            onAmountSelected: (value) {
                              if (value == -1) {
                                ref
                                    .read(withdrawProvider.notifier)
                                    .updateManualAmount('');
                              } else {
                                ref
                                    .read(withdrawProvider.notifier)
                                    .selectPresetAmount(value);
                              }
                            },
                          ),
                          if (state.selectedPresetAmount == null) ...[
                            const SizedBox(height: 12),
                            WithdrawTextField(
                              controller: _amountController,
                              hintText: 'Amount',
                              keyboardType: TextInputType.number,
                              onChanged: ref
                                  .read(withdrawProvider.notifier)
                                  .updateManualAmount,
                            ),
                          ],
                        ] else ...[
                          WithdrawTextField(
                            controller: _amountController,
                            hintText: 'Amount',
                            keyboardType: TextInputType.number,
                            onChanged: ref
                                .read(withdrawProvider.notifier)
                                .updateManualAmount,
                          ),
                        ],
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: state.isValid && !state.isSubmitting
                                ? () async {
                                    final success = await ref
                                        .read(withdrawProvider.notifier)
                                        .submitWithdraw();

                                    if (success && context.mounted) {
                                      context.pushNamed('withdraw-success');
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
                            child: state.isSubmitting
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Verify',
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
