enum BeneficiaryGroupType {
  cardNumber,
  sameBank,
  anotherBank,
}

enum BeneficiaryTransferType {
  cardNumber,
  sameBank,
  anotherBank,
}

class BeneficiaryModel {
  final String name;
  final String number;
  final String image;
  final BeneficiaryGroupType groupType;

  const BeneficiaryModel({
    required this.name,
    required this.number,
    required this.image,
    required this.groupType,
  });
}