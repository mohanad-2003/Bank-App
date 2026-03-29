import 'package:banking_app/features/home/widgets/screen_header.dart';
import 'package:banking_app/features/save-online/providers/management_provider.dart';
import 'package:banking_app/features/save-online/widgets/management_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ManagenetScreen extends ConsumerWidget {
  const ManagenetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(managementProvider);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ScreenHeader(title: 'Management', onBackTap: () => context.pop()),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, _) => SizedBox(height: 10),
                  itemCount: data.length,
                  itemBuilder: (contex, index) {
                    return ManagementCard(item: data[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
