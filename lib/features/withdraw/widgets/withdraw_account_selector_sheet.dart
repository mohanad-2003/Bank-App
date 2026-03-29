import 'package:flutter/material.dart';
import 'package:banking_app/features/withdraw/models/withdraw_account_model.dart';

class WithdrawAccountSelectorSheet extends StatelessWidget {
  const WithdrawAccountSelectorSheet({
    super.key,
    required this.accounts,
    required this.selectedAccountId,
  });

  final List<WithdrawAccountModel> accounts;
  final String? selectedAccountId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Choose account:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(16),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      color: Color(0xFF8C8C95),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...accounts.map(
              (account) {
                final isSelected = account.id == selectedAccountId;

                return InkWell(
                  onTap: () => Navigator.of(context).pop(account),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            account.accountNumber,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFF4338D1)
                                  : const Color(0xFF8E8E97),
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: Color(0xFF4338D1),
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}