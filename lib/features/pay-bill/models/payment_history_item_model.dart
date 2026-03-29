enum PaymentHistoryType {
  electric,
  water,
  mobile,
  internet,
}

class PaymentHistoryItemModel {
  final String id;
  final PaymentHistoryType type;
  final String month;
  final String date;
  final String status;
  final bool isSuccessful;
  final String amount;
  final String? company;

  const PaymentHistoryItemModel({
    required this.id,
    required this.type,
    required this.month,
    required this.date,
    required this.status,
    required this.isSuccessful,
    required this.amount,
    this.company,
  });
}