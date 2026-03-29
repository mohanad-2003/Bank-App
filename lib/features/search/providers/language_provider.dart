import 'package:banking_app/features/search/models/language_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final languageListProvider = Provider<List<LanguageItemModel>>((ref) {
  return const [
    LanguageItemModel(name: 'Vietnamese', countryCode: 'VN'),
    LanguageItemModel(name: 'French', countryCode: 'FR'),
    LanguageItemModel(name: 'English', countryCode: 'GB'),
    LanguageItemModel(name: 'Japanese', countryCode: 'JP'),
    LanguageItemModel(name: 'Portuguese', countryCode: 'PT'),
    LanguageItemModel(name: 'China', countryCode: 'CN'),
    LanguageItemModel(name: 'Korea', countryCode: 'KR'),
    LanguageItemModel(name: 'Nicaragua', countryCode: 'NI'),
    LanguageItemModel(name: 'Russia', countryCode: 'RU'),
    LanguageItemModel(name: 'Portuguese', countryCode: 'PT'),
    LanguageItemModel(name: 'French', countryCode: 'FR'),
  ];
});

final selectedLanguageProvider = StateProvider<String>((ref) {
  return 'English';
});