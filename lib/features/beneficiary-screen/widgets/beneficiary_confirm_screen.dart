import 'package:banking_app/features/beneficiary-screen/providers/beneficiary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BeneficiaryConfirmScreen extends ConsumerWidget {
  const BeneficiaryConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addBeneficiaryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = MediaQuery.of(context).padding.top;
          final contentMaxWidth = constraints.maxWidth > 500
              ? 460.0
              : double.infinity;

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  color: const Color(0xFF4338D1),
                  //  padding: EdgeInsets.fromLTRB(20, topPadding + 14, 20, 0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => context.pop(),
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Beneficiary',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// الكونتينر الأبيض
                Positioned(
                  top: 165,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 78, 20, 20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF6F6F8),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(34),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 4),
                            const Center(
                              child: Text(
                                'Push Puttichai',
                                style: TextStyle(
                                  color: Color(0xFF4338D1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 26),

                            _ConfirmLabel(label: 'Choose bank'),
                            const SizedBox(height: 8),
                            _ConfirmValueField(value: state.bankName),

                            const SizedBox(height: 16),

                            _ConfirmLabel(label: 'Choose branch'),
                            const SizedBox(height: 8),
                            _ConfirmValueField(value: state.branchName),

                            const SizedBox(height: 16),

                            _ConfirmLabel(label: 'Transaction name'),
                            const SizedBox(height: 8),
                            _ConfirmValueField(value: state.transactionName),

                            const SizedBox(height: 16),

                            _ConfirmLabel(label: 'Card number'),
                            const SizedBox(height: 8),
                            _ConfirmValueField(value: state.cardNumber),

                            const SizedBox(height: 28),

                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(addBeneficiaryProvider.notifier)
                                      .reset();
                                  context.pop();
                                  context.pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF4338D1),
                                  foregroundColor: Colors.white,
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
                  ),
                ),

                /// الصورة الشخصية بين الأزرق والأبيض
                const Positioned(
                  top: 118,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage('assets/push.png'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ConfirmLabel extends StatelessWidget {
  final String label;

  const _ConfirmLabel({required this.label});

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

class _ConfirmValueField extends StatelessWidget {
  final String value;

  const _ConfirmValueField({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9D9E2)),
      ),
      child: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
