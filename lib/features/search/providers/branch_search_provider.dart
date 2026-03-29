import 'package:banking_app/features/search/models/branch_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final branchSearchTextProvider = StateProvider<String>((ref) => 'Bank');

final branchListProvider = Provider<List<BranchItemModel>>((ref) {
  return const [
    BranchItemModel(
      title: 'Bank 1656 Union Street',
      distance: '50 m',
    ),
    BranchItemModel(
      title: 'Bank Secaucus',
      distance: '1,2 km',
    ),
    BranchItemModel(
      title: 'Bank 1657 Riverside Drive',
      distance: '5,3 km',
    ),
    BranchItemModel(
      title: 'Bank Rutherford',
      distance: '70 m',
    ),
    BranchItemModel(
      title: 'Bank 1656 Union Street',
      distance: '30 m',
    ),
  ];
});