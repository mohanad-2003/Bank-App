import 'package:banking_app/features/search/widgets/currency_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String selectedCurrency;
  final List<String> currencies;
  final ValueChanged<String?> onCurrencyChanged;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const AmountInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.selectedCurrency,
    required this.currencies,
    required this.onCurrencyChanged,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xff9B9B9B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xffE2E2E2)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: Color(0xffC3C3C3),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: const Color(0xffE3E3E3),
              ),
              const SizedBox(width: 12),
              CurrencyDropdown(
                value: selectedCurrency,
                items: currencies,
                onChanged: onCurrencyChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}