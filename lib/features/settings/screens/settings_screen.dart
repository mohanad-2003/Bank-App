import 'package:banking_app/features/settings/providers/settings_provider.dart';
import 'package:banking_app/features/settings/widgets/setting_header.dart';
import 'package:banking_app/features/settings/widgets/settings_menu_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfo = ref.watch(appInfoProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 34),
              decoration: const BoxDecoration(
                color: Color(0xff4338D8),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Setting',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -18),
              child: Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  decoration: const BoxDecoration(
                    color: Color(0xffF8F8FA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(26),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SettingsHeader(
                        userName: 'Push Puttichai',
                        imagePath: 'assets/profile.png',
                      ),
                      const SizedBox(height: 18),
                      SettingsMenuTile(
                        title: 'Password',
                        onTap: () => context.push('/change-password'),
                      ),
                      SettingsMenuTile(
                        title: 'Touch ID',
                        onTap: () {},
                      ),
                      SettingsMenuTile(
                        title: 'Languages',
                        onTap: () => context.push('/language'),
                      ),
                      SettingsMenuTile(
                        title: 'App information',
                        onTap: () => context.push('/app-information'),
                      ),
                      SettingsMenuTile(
                        title: 'Customer care',
                        trailingText: appInfo['customerCare'],
                        showArrow: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}