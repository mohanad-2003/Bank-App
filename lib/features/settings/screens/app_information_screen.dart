import 'package:banking_app/features/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppInformationScreen extends ConsumerWidget {
  const AppInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfo = ref.watch(appInfoProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (context.canPop()) context.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'App information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2D2D2D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Center(
                child: Text(
                  appInfo['appName'] ?? '',
                  style: const TextStyle(
                    color: Color(0xff3A3A3A),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _infoRow('Date of manufacture', appInfo['dateOfManufacture'] ?? ''),
              _divider(),
              _infoRow('Version', appInfo['version'] ?? ''),
              _divider(),
              _infoRow('Language', appInfo['language'] ?? ''),
              _divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xff4A4A4A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xff4338D8),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: const Color(0xffECECEC),
    );
  }
}