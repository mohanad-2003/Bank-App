import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExchangeAmountField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String currencyCode;
  final VoidCallback onCurrencyTap;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const ExchangeAmountField({
    super.key,
    required this.label,
    required this.controller,
    required this.currencyCode,
    required this.onCurrencyTap,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xff989898),
            fontSize: 13,
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
            border: Border.all(color: const Color(0xffE3E3E3)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: readOnly,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  onChanged: onChanged,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                      color: Color(0xffC5C5C5),
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xff2F2F2F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: const Color(0xffE3E3E3),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: onCurrencyTap,
                child: Row(
                  children: [
                    Text(
                      currencyCode,
                      style: const TextStyle(
                        color: Color(0xff8A8A8A),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xff8A8A8A),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}