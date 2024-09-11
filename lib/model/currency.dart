class CountryCurrency {
  final String country;
  final String currency;
  final String abbreviation;

  CountryCurrency({
    required this.country,
    required this.currency,
    required this.abbreviation,
  });

  // Factory method to create a CountryCurrency from JSON
  factory CountryCurrency.fromJson(Map<String, dynamic> json) {
    return CountryCurrency(
      country: json['country'],
      currency: json['currency'],
      abbreviation: json['abbreviation'],
    );
  }
}
