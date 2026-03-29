import 'package:banking_app/features/home/widgets/bank_and_card_widgets.dart';
import 'package:banking_app/features/save-online/providers/save_online_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:banking_app/features/home/widgets/screen_header.dart';

class ChooseSaveOnlineCardScreen extends ConsumerWidget {
  const ChooseSaveOnlineCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(saveOnlineProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      ScreenHeader(
                        title: 'Choose card',
                        onBackTap: () => context.pop(),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                state.cards.length,
                                (index) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index == state.cards.length - 1 ? 0 : 16,
                                  ),
                                  child: BankCardWidget(
                                    item: state.cards[index],
                                    onTap: () {
                                      ref
                                          .read(saveOnlineProvider.notifier)
                                          .selectCard(state.cards[index]);
                                      context.pop();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Container(
                                width: double.infinity,
                                height: 56,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFB9B4F4),
                                    width: 1.2,
                                  ),
                                ),
                                child: const Text(
                                  'Add new card',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF8E86E8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
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