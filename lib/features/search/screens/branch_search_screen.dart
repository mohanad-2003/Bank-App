import 'package:banking_app/features/search/providers/branch_search_provider.dart';
import 'package:banking_app/features/search/widgets/branch_app_bar.dart';
import 'package:banking_app/features/search/widgets/branch_list_title.dart';
import 'package:banking_app/features/search/widgets/branch_search_field.dart';
import 'package:banking_app/features/search/widgets/fake_map_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BranchSearchScreen extends ConsumerWidget {
  const BranchSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branches = ref.watch(branchListProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final screenHeight = constraints.maxHeight;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    12,
                    horizontalPadding,
                    0,
                  ),
                  child: const BranchAppBar(),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Column(
                        children: [
                          const FakeMapSection(),
                          Transform.translate(
                            offset: const Offset(0, -18),
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                minHeight: screenHeight * 0.42,
                              ),
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                16,
                                16,
                                10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffF4F4F6),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 42,
                                    height: 5,
                                    margin: const EdgeInsets.only(bottom: 14),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD2D2D2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  const BranchSearchField(),
                                  const SizedBox(height: 12),
                                  ListView.separated(
                                    itemCount: branches.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 2),
                                    itemBuilder: (context, index) {
                                      return BranchListTile(
                                        item: branches[index],
                                      );
                                    },
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
                        ],
                      ),
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
