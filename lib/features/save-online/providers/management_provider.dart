import 'package:banking_app/features/save-online/models/save_account_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final managementProvider = Provider<List<SaveAccountModel>>((ref) {
  return const [
    SaveAccountModel(
      accountNumber: '1900 8988 5456',
      fromDate: '02/11/2019',
      toDate: '02/11/2020',
      duration: '12 months',
      interest: '5%',
    ),
    SaveAccountModel(
      accountNumber: '1900 8112 5222',
      fromDate: '02/11/2019',
      toDate: '02/11/2020',
      duration: '12 months',
      interest: '5%',
    ),
  ];
});