import 'package:banking_app/features/search/models/currency_rate_model.dart';

class ExchangeService {
  Future<List<CurrencyRateModel>> fetchRates() async {
    return const [
      CurrencyRateModel(code: 'USD', rateToUsd: 1.0),
      CurrencyRateModel(code: 'EUR', rateToUsd: 1.09),
      CurrencyRateModel(code: 'GBP', rateToUsd: 1.27),
      CurrencyRateModel(code: 'JPY', rateToUsd: 0.0067),
      CurrencyRateModel(code: 'SAR', rateToUsd: 0.2666),
      CurrencyRateModel(code: 'AED', rateToUsd: 0.2722),
      CurrencyRateModel(code: 'EGP', rateToUsd: 0.0202),
    ];
  }
}