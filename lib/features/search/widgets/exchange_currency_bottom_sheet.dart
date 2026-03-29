import 'package:banking_app/features/search/providers/exchange_provider.dart';
import 'package:flutter/material.dart';

class ExchangeCurrencyBottomSheet extends StatelessWidget {
  final String selectedCode;
  final List<ExchangeRateItem> items;
  final ValueChanged<String> onSelected;

  const ExchangeCurrencyBottomSheet({
    super.key,
    required this.selectedCode,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Select the currency',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2E2E2E),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Color(0xff808080),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...items.map(
              (item) => InkWell(
                onTap: () {
                  onSelected(item.code);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.code} (${item.name})',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: item.code == selectedCode
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: item.code == selectedCode
                                ? const Color(0xff4A3FE2)
                                : const Color(0xff666666),
                          ),
                        ),
                      ),
                      if (item.code == selectedCode)
                        const Icon(
                          Icons.check,
                          color: Color(0xff4A3FE2),
                          size: 18,
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