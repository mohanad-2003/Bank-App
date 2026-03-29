import 'package:flutter/material.dart';

class SaveOnlineCardModel {
  final String holderName;
  final String type;
  final String number;
  final String amount;
  final String scheme;
  final SaveOnlineCardTheme theme;

  const SaveOnlineCardModel({
    required this.holderName,
    required this.type,
    required this.number,
    required this.amount,
    required this.scheme,
    required this.theme,
  });
}

enum SaveOnlineCardTheme {
  blue,
  orange,
}

class SaveOnlineCardThemeConfig {
  final List<Color> gradientColors;
  final Color bigCircleColor;
  final Color topRightShapeColor;

  const SaveOnlineCardThemeConfig({
    required this.gradientColors,
    required this.bigCircleColor,
    required this.topRightShapeColor,
  });

  factory SaveOnlineCardThemeConfig.fromTheme(SaveOnlineCardTheme theme) {
    switch (theme) {
      case SaveOnlineCardTheme.blue:
        return const SaveOnlineCardThemeConfig(
          gradientColors: [
            Color(0xFF28209E),
            Color(0xFF3098FF),
          ],
          bigCircleColor: Color(0xFF3828B0),
          topRightShapeColor: Color(0x55FFFFFF),
        );
      case SaveOnlineCardTheme.orange:
        return const SaveOnlineCardThemeConfig(
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