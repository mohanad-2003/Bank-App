import 'package:banking_app/features/beneficiary-screen/providers/beneficiary_provider.dart';
import 'package:banking_app/features/beneficiary-screen/widgets/beneficiary_transfer_type_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddBeneficiaryScreen extends ConsumerStatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  ConsumerState<AddBeneficiaryScreen> createState() =>
      _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends ConsumerState<AddBeneficiaryScreen> {
  late final TextEditingController _bankController;
  late final TextEditingController _branchController;
  late final TextEditingController _transactionController;
  late final TextEditingController _cardController;

  @override
  void initState() {
    super.initState();
    _bankController = TextEditingController();
    _branchController = TextEditingController();
    _transactionController = TextEditingController();
    _cardController = TextEditingController();
  }

  @override
  void dispose() {
    _bankController.dispose();
    _branchController.dispose();
    _transactionController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addBeneficiaryProvider);

    if (_bankController.text != state.bankName) {
      _bankController.value = TextEditingValue(
        text: state.bankName,
        selection: TextSelection.collapsed(offset: state.bankName.length),
      );
    }
    if (_branchController.text != state.branchName) {
      _branchController.value = TextEditingValue(
        text: state.branchName,
        selection: TextSelection.collapsed(offset: state.branchName.length),
      );
    }
    if (_transactionController.text != state.transactionName) {
      _transactionController.value = TextEditingValue(
        text: state.transactionName,
        selection: TextSelection.collapsed(
          offset: state.transactionName.length,
        ),
      );
    }
    if (_cardController.text != state.cardNumber) {
      _cardController.value = TextEditingValue(
        text: state.cardNumber,
        selection: TextSelection.collapsed(offset: state.cardNumber.length),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F6F8),
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
                        Row(
                          children: [
                            InkWell(
                              onTap: () => context.pop(),
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 20,
                                  color: Color(0xFF222222),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Add new',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF222222),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _AvatarPickerSection(
                          imagePath: state.imagePath,
                          onAddTap: () {
                            ref
                                .read(addBeneficiaryProvider.notifier)
                                .updateImage('assets/push.png');
                          },
                          onEditTap: () {
                            ref
                                .read(addBeneficiaryProvider.notifier)
                                .updateImage('assets/push.png');
                          },
                        ),
                        const SizedBox(height: 18),
                        BeneficiaryTransferTypeTabs(
                          selectedType: state.selectedType,
                          onChanged: (value) {
                            ref
                                .read(addBeneficiaryProvider.notifier)
                                .updateType(value);
                          },
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _FieldLabel(label: 'Choose bank'),
                              const SizedBox(height: 8),
                              _BeneficiaryTextField(
                                controller: _bankController,
                                hintText: 'Choose bank',
                                suffixIcon: Icons.keyboard_arrow_down_rounded,
                                onChanged: ref
                                    .read(addBeneficiaryProvider.notifier)
                                    .updateBankName,
                              ),
                              const SizedBox(height: 14),
                              _FieldLabel(label: 'Choose branch'),
                              const SizedBox(height: 8),
                              _BeneficiaryTextField(
                                controller: _branchController,
                                hintText: 'Choose branch',
                                suffixIcon: Icons.keyboard_arrow_down_rounded,
                                onChanged: ref
                                    .read(addBeneficiaryProvider.notifier)
                                    .updateBranchName,
                              ),
                              const SizedBox(height: 14),
                              _FieldLabel(label: 'Transaction name'),
                              const SizedBox(height: 8),
                              _BeneficiaryTextField(
                                controller: _transactionController,
                                hintText: 'Transaction name',
                                onChanged: ref
                                    .read(addBeneficiaryProvider.notifier)
                                    .updateTransactionName,
                              ),
                              const SizedBox(height: 14),
                              _FieldLabel(label: 'Card number'),
                              const SizedBox(height: 8),
                              _BeneficiaryTextField(
                                controller: _cardController,
                                hintText: 'Card number',
                                keyboardType: TextInputType.number,
                                onChanged: ref
                                    .read(addBeneficiaryProvider.notifier)
                                    .updateCardNumber,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: state.isValid
                                      ? () =>
                                            context.push('/beneficiary-confirm')
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF4338D1),
                                    disabledBackgroundColor: const Color(
                                      0xFFE7E5F4,
                                    ),
                                    foregroundColor: Colors.white,
                                    disabledForegroundColor: Colors.white70,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'Save to directory',
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
                        const SizedBox(height: 16),
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

class _AvatarPickerSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback onAddTap;
  final VoidCallback onEditTap;

  const _AvatarPickerSection({
    required this.imagePath,
    required this.onAddTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath.isNotEmpty;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EFF8),
                shape: BoxShape.circle,
                image: hasImage
                    ? DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: hasImage
                  ? null
                  : const Icon(Icons.person, size: 52, color: Colors.white),
            ),
            Positioned(
              right: -2,
              bottom: 6,
              child: GestureDetector(
                onTap: hasImage ? onEditTap : onAddTap,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4338D1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    hasImage ? Icons.edit_rounded : Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          hasImage ? 'Push Puttichai' : 'Push Puttichai',
          style: const TextStyle(
            color: Color(0xFF4338D1),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFF9999A3),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _BeneficiaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  const _BeneficiaryTextField({
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFFB9B9C2),
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: const Color(0xFF9999A3))
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD9D9E2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4338D1)),
          ),
        ),
      ),
    );
  }
}
