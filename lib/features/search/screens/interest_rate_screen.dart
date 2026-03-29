import 'package:banking_app/features/search/providers/interest_rate_provider.dart';
import 'package:banking_app/features/search/widgets/interest_rate_app_bar.dart';
import 'package:banking_app/features/search/widgets/interest_rate_header_row.dart';
import 'package:banking_app/features/search/widgets/interest_rate_row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestRateScreen extends ConsumerWidget {
  const InterestRateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rates = ref.watch(interestRateListProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    12,
                    horizontalPadding,
                    0,
                  ),
                  child: const InterestRateAppBar(),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        const InterestRateHeaderRow(),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: rates.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),
                            itemBuilder: (context, index) {
                              return InterestRateRowItem(
                                item: rates[index],
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 44,
                          height: 5,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}