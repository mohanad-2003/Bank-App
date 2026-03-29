import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banking_app/features/search/providers/branch_search_provider.dart';

class BranchSearchField extends ConsumerWidget {
  const BranchSearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(branchSearchTextProvider);

    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffE1E1E1)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(
            Icons.search,
            color: Color(0xff6E6E6E),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff404040),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              ref.read(branchSearchTextProvider.notifier).state = '';
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.close,
                color: Color(0xffA3A3A3),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}