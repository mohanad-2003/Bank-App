import 'package:banking_app/core/widgets/custom_button_nav_bar.dart';
import 'package:banking_app/features/home/screens/home_screen.dart';
import 'package:banking_app/features/message/screens/message_screen.dart';
import 'package:banking_app/features/search/screens/search_screen.dart';
import 'package:banking_app/features/navigation/providers/bavigation_provider.dart';
import 'package:banking_app/features/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    MessagesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(navigationIndexProvider.notifier).state = index,
      ),
    );
  }
}
