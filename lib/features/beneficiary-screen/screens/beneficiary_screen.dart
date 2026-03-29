import 'package:banking_app/features/beneficiary-screen/models/beneficiary_model.dart';
import 'package:banking_app/features/beneficiary-screen/providers/beneficiary_provider.dart';
import 'package:banking_app/features/beneficiary-screen/widgets/beneficiary_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BeneficiaryScreen extends ConsumerWidget {
  const BeneficiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(beneficiaryProvider);

    final cardNumberItems = data
        .where((e) => e.groupType == BeneficiaryGroupType.cardNumber)
        .toList();
    final sameBankItems = data
        .where((e) => e.groupType == BeneficiaryGroupType.sameBank)
        .toList();
    final anotherBankItems = data
        .where((e) => e.groupType == BeneficiaryGroupType.anotherBank)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-beneficiary'),
        backgroundColor: const Color(0xFF4338D1),
        elevation: 2,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final contentMaxWidth =
                constraints.maxWidth > 500 ? 460.0 : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  child: Column(
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
                              'Beneficiary',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF444444),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            BeneficiaryGroupCard(
                              title: 'Transfer via card number',
                              items: cardNumberItems,
                            ),
                            const SizedBox(height: 18),
                            BeneficiaryGroupCard(
                              title: 'Transfer to the same bank',
                              items: sameBankItems,
                            ),
                            const SizedBox(height: 18),
                            BeneficiaryGroupCard(
                              title: 'Transfer to another bank',
                              items: anotherBankItems,
                            ),
                            const SizedBox(height: 30),
                          ],
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