class ExchangeRateItemModel {
  final String country;
 final String countryCode; 
  final String buy;
  final String sell;
  

  const ExchangeRateItemModel({
    required this.country,
    required this.countryCode,
    required this.buy,
    required this.sell,
  });
}