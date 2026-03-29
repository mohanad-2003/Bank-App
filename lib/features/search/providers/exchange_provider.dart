import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ExchangeRateItem {
  final String code;
  final String name;
  final double ratePerUsd;

  const ExchangeRateItem({
    required this.code,
    required this.name,
    required this.ratePerUsd,
  });
}

final exchangeRatesProvider = Provider<List<ExchangeRateItem>>((ref) {
  return const [
    ExchangeRateItem(code: 'USD', name: 'Dollar', ratePerUsd: 1.0),
    ExchangeRateItem(code: 'VND', name: 'Viet Nam Dong', ratePerUsd: 24500),
    ExchangeRateItem(code: 'HK\$', name: 'Hong Kong Dollar', ratePerUsd: 7.82),
    ExchangeRateItem(code: 'NT\$', name: 'Taiwan Dollar', ratePerUsd: 31.45),
    ExchangeRateItem(code: 'J\$', name: 'Jamaika Dollar', ratePerUsd: 156.20),
    ExchangeRateItem(code: 'KRM', name: 'Korean Money', ratePerUsd: 112.00),
  ];
});

class ExchangeState {
  final String fromCurrency;
  final String toCurrency;
  final String fromAmount;
  final String toAmount;

  const ExchangeState({
    this.fromCurrency = 'USD',
    this.toCurrency = 'KRM',
    this.fromAmount = '',
    this.toAmount = '',
  });

  bool get canExchange => double.tryParse(fromAmount) != null;

  ExchangeState copyWith({
    String? fromCurrency,
    String? toCurrency,
    String? fromAmount,
    String? toAmount,
  }) {
    return ExchangeState(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
    );
  }
}

final exchangeProvider =
    StateNotifierProvider<ExchangeNotifier, ExchangeState>((ref) {
  return ExchangeNotifier(ref);
});

class ExchangeNotifier extends StateNotifier<ExchangeState> {
  final Ref ref;

  ExchangeNotifier(this.ref) : super(const ExchangeState());

  List<ExchangeRateItem> get _rates => ref.read(exchangeRatesProvider);

  void updateFromAmount(String value) {
    state = state.copyWith(fromAmount: value);
    calculate();
  }

  void updateFromCurrency(String value) {
    state = state.copyWith(fromCurrency: value);
    calculate();
  }

  void updateToCurrency(String value) {
    state = state.copyWith(toCurrency: value);
    calculate();
  }

  void swapCurrencies() {
    state = state.copyWith(
      fromCurrency: state.toCurrency,
      toCurrency: state.fromCurrency,
      fromAmount: state.toAmount,
      toAmount: state.fromAmount,
    );
    calculate();
  }

  void calculate() {
    final amount = double.tryParse(state.fromAmount);

    if (amount == null || amount <= 0) {
      state = state.copyWith(toAmount: '');
      return;
    }

    final fromRate = _rates.firstWhere((e) => e.code == state.fromCurrency);
    final toRate = _rates.firstWhere((e) => e.code == state.toCurrency);

    final usdValue = amount / fromRate.ratePerUsd;
    final converted = usdValue * toRate.ratePerUsd;

    state = state.copyWith(toAmount: converted.toStringAsFixed(0));
  }

  String getRateText() {
    final fromRate = _rates.firstWhere((e) => e.code == state.fromCurrency);
    final toRate = _rates.firstWhere((e) => e.code == state.toCurrency);

    final result = toRate.ratePerUsd / fromRate.ratePerUsd;

    String formatNumber(double value) {
      if (value % 1 == 0) return value.toStringAsFixed(0);
      if (value < 10) return value.toStringAsFixed(2);
      return value.toStringAsFixed(0);
    }

    return '1 ${state.fromCurrency} = ${formatNumber(result)} ${state.toCurrency}';
  }

  String getCurrencyName(String code) {
    return _rates.firstWhere((e) => e.code == code).name;
  }

  List<ExchangeRateItem> get currencies => _rates;
}