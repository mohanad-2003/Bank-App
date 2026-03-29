import 'package:banking_app/features/transfer/providers/transfer_provider.dart';
import 'package:banking_app/features/transfer/widgets/beneficiary_avatar_item.dart';
import 'package:banking_app/features/transfer/widgets/transfer_account_dropdown.dart';
import 'package:banking_app/features/transfer/widgets/transfer_bank_bootom_sheet.dart';
import 'package:banking_app/features/transfer/widgets/transfer_section_title.dart';
import 'package:banking_app/features/transfer/widgets/transfer_text_field.dart';
import 'package:banking_app/features/transfer/widgets/transfer_type_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  late final TextEditingController bankController;
  late final TextEditingController branchController;
  late final TextEditingController nameController;
  late final TextEditingController cardNumberController;
  late final TextEditingController amountController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    bankController = TextEditingController();
    branchController = TextEditingController();
    nameController = TextEditingController();
    cardNumberController = TextEditingController();
    amountController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    bankController.dispose();
    branchController.dispose();
    nameController.dispose();
    cardNumberController.dispose();
    amountController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _openBankBottomSheet(List<String> banks, String selectedBank) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return TransferBankBottomSheet(
          banks: banks,
          selectedBank: selectedBank,
          onSelected: (value) {
            ref.read(transferProvider.notifier).selectBank(value);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transferProvider);
    final notifier = ref.read(transferProvider.notifier);
    final accounts = ref.watch(transferAccountsProvider);
    final transferTypes = ref.watch(transferTypesProvider);
    final beneficiaries = ref.watch(beneficiariesProvider);
    final banks = ref.watch(banksProvider);

    bankController.text = state.selectedBank;
    branchController.text = state.selectedBranch;
    if (nameController.text != state.name) nameController.text = state.name;
    if (cardNumberController.text != state.cardNumber) {
      cardNumberController.text = state.cardNumber;
    }
    if (amountController.text != state.amount) {
      amountController.text = state.amount;
    }
    if (contentController.text != state.content) {
      contentController.text = state.content;
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                        'Transfer',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2D2D2D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  TransferAccountDropdown(
                    value: state.selectedAccount,
                    items: accounts.map((e) => e.title).toList(),
                    onChanged: (value) {
                      if (value != null) notifier.selectAccount(value);
                    },
                  ),
                  const SizedBox(height: 6),
                  if (state.selectedAccount.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Available balance: ${accounts.firstWhere((e) => e.title == state.selectedAccount).balance}',
                        style: const TextStyle(
                          color: Color(0xff4A3FE2),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 14),
                  const TransferSectionTitle(title: 'Choose transaction'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...List.generate(transferTypes.length, (index) {
                        final item = transferTypes[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == transferTypes.length - 1 ? 0 : 8,
                          ),
                          child: TransferTypeCard(
                            item: item,
                            isSelected: state.selectedTransferType == item.id,
                            onTap: () => notifier.selectTransferType(item.id),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TransferSectionTitle(
                    title: 'Choose beneficiary',
                    actionText: 'Find beneficiary',
                    onActionTap: () {},
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      BeneficiaryAvatarItem(
                        name: '',
                        isSelected: false,
                        isAddButton: true,
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      ...List.generate(beneficiaries.length, (index) {
                        final item = beneficiaries[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == beneficiaries.length - 1 ? 0 : 10,
                          ),
                          child: BeneficiaryAvatarItem(
                            name: item.name,
                            imagePath: item.imagePath,
                            isSelected: state.selectedBeneficiaryIndex == index,
                            isAddButton: false,
                            onTap: () {
                              notifier.selectBeneficiary(index, item.name);
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.isOtherBank) ...[
                    TransferTextField(
                      hint: 'Choose bank',
                      controller: bankController,
                      readOnly: true,
                      onTap: () {
                        _openBankBottomSheet(banks, state.selectedBank);
                      },
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: Color(0xff9A9A9A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TransferTextField(
                      hint: 'Choose branch',
                      controller: branchController,
                      readOnly: true,
                      onTap: () {
                        notifier.selectBranch('New York');
                      },
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: Color(0xff9A9A9A),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  TransferTextField(
                    hint: 'Name',
                    controller: nameController,
                    onChanged: notifier.updateName,
                  ),
                  const SizedBox(height: 10),
                  TransferTextField(
                    hint: 'Card number',
                    controller: cardNumberController,
                    onChanged: notifier.updateCardNumber,
                  ),
                  const SizedBox(height: 10),
                  TransferTextField(
                    hint: 'Amount',
                    controller: amountController,
                    onChanged: notifier.updateAmount,
                  ),
                  if (notifier.amountInWords().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        notifier.amountInWords(),
                        style: const TextStyle(
                          color: Color(0xff4A3FE2),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  TransferTextField(
                    hint: state.isOtherBank ? 'Note' : 'Content',
                    controller: contentController,
                    onChanged: notifier.updateContent,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: notifier.toggleSaveBeneficiary,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: state.saveBeneficiary
                                ? const Color(0xff4A3FE2)
                                : Colors.transparent,
                            border: Border.all(color: const Color(0xffBEBEBE)),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: state.saveBeneficiary
                              ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Save to directory of beneficiary',
                        style: TextStyle(
                          color: Color(0xff6C6C6C),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: state.canConfirm
                          ? () {
                              context.push('/transfer-confirm');
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: state.canConfirm
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
