import 'package:banking_app/features/search/models/language_item_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class LanguageRowItem extends StatelessWidget {
  final LanguageItemModel item;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageRowItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CountryFlag.fromCountryCode(
                item.countryCode,
            
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xff2E2E2E)
                      : const Color(0xff8F8F8F),
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: Color(0xff4C42D8),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}