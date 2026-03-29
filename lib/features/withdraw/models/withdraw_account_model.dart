class WithdrawAccountModel {
  final String id;
  final String accountNumber;
  final double availableBalance;

  const WithdrawAccountModel({
    required this.id,
    required this.accountNumber,
    required this.availableBalance,
  });
}