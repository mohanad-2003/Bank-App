class SaveAccountModel {
  final String accountNumber;
  final String fromDate;
  final String toDate;
  final String duration;
  final String interest;

  const SaveAccountModel({
    required this.accountNumber,
    required this.fromDate,
    required this.toDate,
    required this.duration,
    required this.interest,
  });
}