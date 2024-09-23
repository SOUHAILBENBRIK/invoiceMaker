// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  CountryCurrency copyWith({
    String? country,
    String? currency,
    String? abbreviation,
  }) {
    return CountryCurrency(
      country: country ?? this.country,
      currency: currency ?? this.currency,
      abbreviation: abbreviation ?? this.abbreviation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'currency': currency,
      'abbreviation': abbreviation,
    };
  }

  factory CountryCurrency.fromMap(Map<String, dynamic> map) {
    return CountryCurrency(
      country: map['country'] as String,
      currency: map['currency'] as String,
      abbreviation: map['abbreviation'] as String,
    );
  }

  String toJson() => json.encode(toMap());



  @override
  String toString() => 'CountryCurrency(country: $country, currency: $currency, abbreviation: $abbreviation)';

  @override
  bool operator ==(covariant CountryCurrency other) {
    if (identical(this, other)) return true;
  
    return 
      other.country == country &&
      other.currency == currency &&
      other.abbreviation == abbreviation;
  }

  @override
  int get hashCode => country.hashCode ^ currency.hashCode ^ abbreviation.hashCode;
}
