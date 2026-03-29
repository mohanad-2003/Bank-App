import 'package:banking_app/features/mobile-prepaid/providers/mobile_prepaid_provider.dart';
import 'package:banking_app/features/mobile-prepaid/widgets/beneficiary_avatar_card.dart';
import 'package:banking_app/features/mobile-prepaid/widgets/prepaid_amount_selector.dart';
import 'package:banking_app/features/mobile-prepaid/widgets/prepaid_labeled_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:banking_app/features/home/widgets/screen_header.dart';

class MobilePrepaidScreen extends ConsumerStatefulWidget {
  const MobilePrepaidScreen({super.key});

  @override
  ConsumerState<MobilePrepaidScreen> createState() =>
      _MobilePrepaidScreenState();
}

class _MobilePrepaidScreenState extends ConsumerState<MobilePrepaidScreen> {
  late final TextEditingController _accountController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mobilePrepaidProvider);

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
                        title: 'Mobile prepaid',
                        onBackTap: () => context.pop(),
                      ),
                      const SizedBox(height: 18),
                      PrepaidLabeledField(
                        label: '',
                        controller: _accountController,
                        hintText: 'Choose account / card',
                        readOnly: true,
                        suffix: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF9999A3),
                        ),
                      ),
                      if (state.selectedAccount != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Available balance: ${state.selectedAccount!.availableBalance.toStringAsFixed(0)}\$',
                          style: const TextStyle(
                            color: Color(0xFF4338D1),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Directory',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9999A3),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Find beneficiary',
                              style: TextStyle(
                                color: Color(0xFF4338D1),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7FB),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color(0xFFD5D5E0),
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ...List.generate(state.beneficiaries.length, (
                              index,
                            ) {
                              final beneficiary = state.beneficiaries[index];
                              final isSelected =
                                  state.selectedBeneficiary?.id ==
                                  beneficiary.id;

                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index == state.beneficiaries.length - 1
                                      ? 0
                                      : 12,
                                ),
                                child: BeneficiaryAvatarCard(
                                  beneficiary: beneficiary,
                                  isSelected: isSelected,
                                  onTap: () {
                                    ref
                                        .read(mobilePrepaidProvider.notifier)
                                        .selectBeneficiary(beneficiary);
                                    ref
                                        .read(mobilePrepaidProvider.notifier)
                                        .selectAccount(state.accounts.first);
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrepaidLabeledField(
                        label: 'Phone number',
                        controller: _phoneController,
                        hintText: 'Phone number',
                        keyboardType: TextInputType.phone,
                        onChanged: ref
                            .read(mobilePrepaidProvider.notifier)
                            .updatePhoneNumber,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Choose amount',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9999A3),
                        ),
                      ),
                      const SizedBox(height: 8),
                      PrepaidAmountSelector(
                        selectedAmount: state.selectedAmount,
                        onSelected: (amount) {
                          ref
                              .read(mobilePrepaidProvider.notifier)
                              .selectAmount(amount);
                          ref
                              .read(mobilePrepaidProvider.notifier)
                              .selectAccount(state.accounts.first);
                        },
                      ),
                      const SizedBox(height: 34),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: state.canContinueToConfirm
                              ? () =>
                                    context.pushNamed('mobile-prepaid-confirm')
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
