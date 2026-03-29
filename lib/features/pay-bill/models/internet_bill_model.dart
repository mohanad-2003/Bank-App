class InternetBillModel {
  final String name;
  final String address;
  final String phoneNumber;
  final String code;
  final String fromDate;
  final String toDate;
  final String fee;
  final String tax;
  final String total;

  const InternetBillModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.code,
    required this.fromDate,
    required this.toDate,
    required this.fee,
    required this.tax,
    required this.total,
  });
}
