import 'package:banking_app/features/search/providers/exchange_provider.dart';
import 'package:banking_app/features/search/widgets/exchange_amount_field.dart';
import 'package:banking_app/features/search/widgets/exchange_app_bar.dart';
import 'package:banking_app/features/search/widgets/exchange_currency_bottom_sheet.dart';
import 'package:banking_app/features/search/widgets/exchange_rate_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExchangeScreen extends ConsumerStatefulWidget {
  const ExchangeScreen({super.key});

  @override
  ConsumerState<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends ConsumerState<ExchangeScreen> {
  late final TextEditingController fromController;
  late final TextEditingController toController;

  @override
  void initState() {
    super.initState();
    fromController = TextEditingController();
    toController = TextEditingController();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  void _showCurrencySheet({
    required String selectedCode,
    required List<ExchangeRateItem> items,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ExchangeCurrencyBottomSheet(
          selectedCode: selectedCode,
          items: items,
          onSelected: onSelected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exchangeProvider);
    final notifier = ref.read(exchangeProvider.notifier);
    final currencies = notifier.currencies;

    if (fromController.text != state.fromAmount) {
      fromController.text = state.fromAmount;
      fromController.selection = TextSelection.fromPosition(
        TextPosition(offset: fromController.text.length),
      );
    }

    if (toController.text != state.toAmount) {
      toController.text = state.toAmount;
      toController.selection = TextSelection.fromPosition(
        TextPosition(offset: toController.text.length),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ExchangeAppBar(),
                  const SizedBox(height: 18),
                  Center(
                    child: Image.asset(
                      'assets/ex.png',
                      height: 175,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 175,
                          child: Center(
                            child: Icon(
                              Icons.currency_exchange,
                              size: 70,
                              color: Color(0xff4A3FE2),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7FA),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      children: [
                        ExchangeAmountField(
                          label: 'From',
                          controller: fromController,
                          currencyCode: state.fromCurrency,
                          onChanged: notifier.updateFromAmount,
                          onCurrencyTap: () {
                            _showCurrencySheet(
                              selectedCode: state.fromCurrency,
                              items: currencies,
                              onSelected: notifier.updateFromCurrency,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: notifier.swapCurrencies,
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Color(0xff4A3FE2),
                                      size: 24,
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Color(0xffFF4D7E),
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ExchangeAmountField(
                          label: 'To',
                          controller: toController,
                          currencyCode: state.toCurrency,
                          readOnly: true,
                          onCurrencyTap: () {
                            _showCurrencySheet(
                              selectedCode: state.toCurrency,
                              items: currencies,
                              onSelected: notifier.updateToCurrency,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ExchangeRateInfo(
                          visible: state.canExchange,
                          rateText: notifier.getRateText(),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state.canExchange
                                ? notifier.calculate
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: state.canExchange
                                  ? const Color(0xff4338D8)
                                  : const Color(0xffE4E1F8),
                              disabledBackgroundColor: const Color(0xffE4E1F8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Exchange',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
