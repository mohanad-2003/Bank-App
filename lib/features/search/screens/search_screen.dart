import 'package:banking_app/features/search/providers/search_provider.dart';
import 'package:banking_app/features/search/widgets/search_header.dart';
import 'package:banking_app/features/search/widgets/search_option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  static const Color primaryColor = Color(0xff3B2CCB);
  static const Color backgroundColor = Color(0xffF6F6F8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(searchItemsProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final topSpacing = constraints.maxHeight * 0.015;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    topSpacing,
                    horizontalPadding,
                    0,
                  ),
                  child: SearchHeader(
                    onBackTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      24,
                    ),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return SearchOptionCard(
                        item: item,
                        onTap: () => context.push(item.route),
                      );
                    },
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