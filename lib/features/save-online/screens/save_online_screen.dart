import 'package:banking_app/features/save-online/providers/save_online_provider.dart';
import 'package:banking_app/features/save-online/widgets/save_online_menue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:banking_app/features/home/widgets/screen_header.dart';

class SaveOnlineScreen extends ConsumerWidget {
  const SaveOnlineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(saveOnlineProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final contentMaxWidth = constraints.maxWidth > 500
                ? 460.0
                : double.infinity;

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
                      ScreenHeader(
                        title: 'Save online',
                        onBackTap: () => context.pop(),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.menuItems.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final item = state.menuItems[index];
                            return SaveOnlineMenuCard(
                              item: item,
                              onTap: () => context.push(item.route),
                            );
                          },
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
