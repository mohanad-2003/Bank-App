import 'package:flutter/material.dart';

class CardItemModel {
  final String holderName;
  final String type;
  final String number;
  final String amount;
  final String scheme;
  final BankCardTheme theme;
  final String maskedCardNumber;
  final String validFrom;
  final String goodThru;
  final String availableBalance;

  const CardItemModel({
    required this.holderName,
    required this.type,
    required this.number,
    required this.amount,
    required this.scheme,
    required this.theme,
    required this.maskedCardNumber,
    required this.validFrom,
    required this.goodThru,
    required this.availableBalance,
  });
}

enum BankCardTheme {
  blue,
  orange,
}

class CardThemeConfig {
  final List<Color> gradientColors;
  final Color bigCircleColor;
  final Color topRightShapeColor;

  const CardThemeConfig({
    required this.gradientColors,
    required this.bigCircleColor,
    required this.topRightShapeColor,
  });

  factory CardThemeConfig.fromTheme(BankCardTheme theme) {
    switch (theme) {
      case BankCardTheme.blue:
        return const CardThemeConfig(
          gradientColors: [
            Color(0xFF28209E),
            Color(0xFF3098FF),
          ],
          bigCircleColor: Color(0xFF3828B0),
          topRightShapeColor: Color(0x55FFFFFF),
        );
      case BankCardTheme.orange:
        return const CardThemeConfig(
          gradientColors: [
            Color(0xFFF2A114),
            Color(0xFFF6C04D),
          ],
          bigCircleColor: Color(0x44FFFFFF),
          topRightShapeColor: Color(0x22FFFFFF),
        );
    }
  }
}