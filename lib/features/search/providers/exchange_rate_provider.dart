import 'package:banking_app/features/search/models/exchange_rate_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exchangeRateListProvider = Provider<List<ExchangeRateItemModel>>((ref) {
  return const [
    ExchangeRateItemModel(
      country: 'Vietnam',
      countryCode: 'VN',
      buy: '1.403',
      sell: '1.746',
    ),
    ExchangeRateItemModel(
      country: 'Nicaragua',
      countryCode: 'NI',
      buy: '9.123',
      sell: '12.09',
    ),
    ExchangeRateItemModel(
      country: 'Korea',
      countryCode: 'KR',
      buy: '3.704',
      sell: '5.151',
    ),
    ExchangeRateItemModel(
      country: 'Russia',
      countryCode: 'RU',
      buy: '116.0',
      sell: '144.4',
    ),
    ExchangeRateItemModel(
      country: 'China',
      countryCode: 'CN',
      buy: '1.725',
      sell: '2.234',
    ),
    ExchangeRateItemModel(
      country: 'Portugal',
      countryCode: 'PT',
      buy: '1.403',
      sell: '1.746',
    ),
    ExchangeRateItemModel(
      country: 'Korea',
      countryCode: 'KR',
      buy: '3.454',
      sell: '4.312',
    ),
    ExchangeRateItemModel(
      country: 'France',
      countryCode: 'FR',
      buy: '23.45',
      sell: '34.56',
    ),
    ExchangeRateItemModel(
      country: 'Nicaragua',
      countryCode: 'NI',
      buy: '263.1',
      sell: '300.3',
    ),
    ExchangeRateItemModel(
      country: 'China',
      countryCode: 'CN',
      buy: '1.725',
      sell: '2.234',
    ),
  ];
});