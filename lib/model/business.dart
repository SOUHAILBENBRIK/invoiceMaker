// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Business {
  final String name;
  final String? userName;
  final String? description;
  final String? address;
  final String? phone;
  final String? email;

  Business({
    required this.name,
    this.userName,
    this.description,
    this.address,
    this.phone,
    this.email,
  });

  Business copyWith({
    String? name,
    String? userName,
    String? description,
    String? address,
    String? phone,
    String? email,
  }) {
    return Business(
      name: name ?? this.name,
      userName: userName ?? this.userName,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userName': userName,
      'description': description,
      'address': address,
      'email': email,
      'phone': phone
    };
  }

  factory Business.fromMap(Map<String, dynamic> map) {
    return Business(
      name: map['name'] as String,
      userName: map['userName'] != null ? map['userName'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Business.fromJson(String source) =>
      Business.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Business(name: $name, userName: $userName, description: $description, address: $address, email: $email , phone : $phone)';
  }

  @override
  bool operator ==(covariant Business other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.userName == userName &&
        other.description == description &&
        other.address == address &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        userName.hashCode ^
        description.hashCode ^
        address.hashCode ^
        email.hashCode ^
    phone.hashCode;
  }
}
