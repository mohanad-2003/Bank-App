import 'package:banking_app/features/search/models/exchange_rate_item_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class ExchangeRateRowItem extends StatelessWidget {
  final ExchangeRateItemModel item;

  const ExchangeRateRowItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CountryFlag.fromCountryCode(item.countryCode),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.country,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.buy,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff4A4A4A),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.sell,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xff4A4A4A),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
