import 'package:banking_app/features/search/models/interest_rate_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interestRateListProvider = Provider<List<InterestRateItemModel>>((ref) {
  return const [
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '1m',
      rate: '4.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Corporate customers',
      deposit: '2m',
      rate: '5.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '1m',
      rate: '4.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Corporate customers',
      deposit: '6m',
      rate: '2.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '1m',
      rate: '4.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Corporate customers',
      deposit: '8m',
      rate: '6.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '1m',
      rate: '4.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '1m',
      rate: '4.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Corporate customers',
      deposit: '7m',
      rate: '6.80%',
    ),
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '1m',
      rate: '4.50%',
    ),
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '12m',
      rate: '5.90%',
    ),
    InterestRateItemModel(
      interestKind: 'Individual customers',
      deposit: '1m',
      rate: '4.50%',
    ),
  ];
});