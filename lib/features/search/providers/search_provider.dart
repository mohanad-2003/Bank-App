import 'package:banking_app/features/search/models/search_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchItemsProvider = Provider<List<SearchItemModel>>((ref) {
  return const [
    SearchItemModel(
      title: 'Branch',
      subtitle: 'Search for branch',
      imagePath: 'assets/branch.png',
      route: '/branch-search',
    ),
    SearchItemModel(
      title: 'Interest rate',
      subtitle: 'Search for interest rate',
      imagePath: 'assets/interest.png',
      route: '/interest-rate',
    ),
    SearchItemModel(
      title: 'Exchange rate',
      subtitle: 'Search for exchange rate',
      imagePath: 'assets/exchange-rate.png',
      route: '/exchange-rate',
    ),
    SearchItemModel(
      title: 'Exchange',
      subtitle: 'Exchange amount of money',
      imagePath: 'assets/exchange.png',
      route: '/exchange',
    ),
    SearchItemModel(
      title: 'Language',
      subtitle: 'Choose your language',
      imagePath: 'assets/language.png',
      route: '/language',
    ),
  ];
});
