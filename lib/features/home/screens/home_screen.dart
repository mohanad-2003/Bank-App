import 'package:banking_app/features/home/providers/home_provider.dart';
import 'package:banking_app/features/home/widgets/home_content_card.dart';
import 'package:banking_app/features/home/widgets/home_top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xff3B2CCB);
  static const Color bgColor = Color(0xffF5F5F7);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(homeUserNameProvider);
    final notificationCount = ref.watch(notificationCountProvider);
    final card = ref.watch(bankCardProvider);
    final actions = ref.watch(homeActionsProvider);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final horizontalPadding = width * 0.06;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: width * 0.05),
                    child: Column(
                      children: [
                        HomeTopHeader(
                          horizontalPadding: horizontalPadding,
                          userName: userName,
                          notificationCount: notificationCount,
                        ),
                        Transform.translate(
                          offset: const Offset(0, -28),
                          child: HomeContentCard(
                            horizontalPadding: horizontalPadding,
                            card: card,
                            actions: actions,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
