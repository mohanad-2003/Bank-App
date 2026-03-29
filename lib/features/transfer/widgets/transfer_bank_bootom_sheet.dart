import 'package:flutter/material.dart';

class TransferBankBottomSheet extends StatelessWidget {
  final List<String> banks;
  final String selectedBank;
  final ValueChanged<String> onSelected;

  const TransferBankBottomSheet({
    super.key,
    required this.banks,
    required this.selectedBank,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose beneficiary bank',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xff2E2E2E),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xffE3E3E3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 18, color: Color(0xffA0A0A0)),
                  SizedBox(width: 8),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Color(0xffB5B5B5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ...banks.map(
              (bank) => InkWell(
                onTap: () {
                  onSelected(bank);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          bank,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff666666),
                          ),
                        ),
                      ),
                      if (bank == selectedBank)
                        const Icon(
                          Icons.check,
                          size: 18,
                          color: Color(0xff4A3FE2),
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