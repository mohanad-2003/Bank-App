import 'package:banking_app/features/save-online/models/save_online_duration_model.dart';
import 'package:banking_app/features/save-online/providers/save_online_provider.dart';
import 'package:banking_app/features/save-online/widgets/save_online_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:banking_app/features/home/widgets/screen_header.dart';

class AddSaveOnlineScreen extends ConsumerStatefulWidget {
  const AddSaveOnlineScreen({super.key});

  @override
  ConsumerState<AddSaveOnlineScreen> createState() =>
      _AddSaveOnlineScreenState();
}

class _AddSaveOnlineScreenState extends ConsumerState<AddSaveOnlineScreen> {
  late final TextEditingController _cardController;
  late final TextEditingController _durationController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _cardController = TextEditingController();
    _durationController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _durationController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _showDurationSheet() async {
    final state = ref.read(saveOnlineProvider);

    final selected = await showModalBottomSheet<SaveOnlineDurationModel>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Choose time deposit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(16),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.close, color: Color(0xFF8C8C95)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...state.durations.map((duration) {
                  final isSelected = state.selectedDuration?.id == duration.id;

                  return InkWell(
                    onTap: () => Navigator.of(context).pop(duration),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          duration.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF4338D1)
                                : const Color(0xFF8E8E97),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      ref.read(saveOnlineProvider.notifier).selectDuration(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(saveOnlineProvider);

    final selectedCardText = state.selectedCard == null
        ? ''
        : 'Account 1900 8988 5456';

    if (_cardController.text != selectedCardText) {
      _cardController.value = TextEditingValue(
        text: selectedCardText,
        selection: TextSelection.collapsed(offset: selectedCardText.length),
      );
    }

    final selectedDurationText =
        state.selectedDuration?.title.split('(').first.trim() ?? '';

    if (_durationController.text != selectedDurationText) {
      _durationController.value = TextEditingValue(
        text: selectedDurationText,
        selection: TextSelection.collapsed(offset: selectedDurationText.length),
      );
    }

    if (_amountController.text != state.amount) {
      _amountController.value = TextEditingValue(
        text: state.amount,
        selection: TextSelection.collapsed(offset: state.amount.length),
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
                          title: 'Add',
                          onBackTap: () => context.pop(),
                        ),
                        const SizedBox(height: 18),
                        Image.asset(
                          'assets/add.png',
                          height: constraints.maxHeight * 0.24,
                          fit: BoxFit.contain,
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
                              SaveOnlineInputField(
                                controller: _cardController,
                                hintText: 'Choose account / card',
                                readOnly: true,
                                onTap: () => context.pushNamed(
                                  'choose-save-online-card',
                                ),
                              ),
                              if (state.selectedCard != null) ...[
                                const SizedBox(height: 8),
                                const Text(
                                  'Available balance: 10000\$',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF4338D1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 14),
                              SaveOnlineInputField(
                                controller: _durationController,
                                hintText: 'Choose time deposit',
                                readOnly: true,
                                onTap: _showDurationSheet,
                              ),
                              if (state.selectedDuration != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  state.selectedDuration!.title,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF4338D1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 14),
                              SaveOnlineInputField(
                                controller: _amountController,
                                hintText: 'Amount (At least \$1000)',
                                keyboardType: TextInputType.number,
                                onChanged: ref
                                    .read(saveOnlineProvider.notifier)
                                    .updateAmount,
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed:
                                      state.isValid && !state.isSubmitting
                                      ? () async {
                                          final ok = await ref
                                              .read(saveOnlineProvider.notifier)
                                              .submit();

                                          if (ok && context.mounted) {
                                            context.pushNamed(
                                              'save-online-success',
                                            );
                                          }
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF4338D1),
                                    disabledBackgroundColor: const Color(
                                      0xFFE5E4F4,
                                    ),
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
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
