
import 'dart:convert';

class ClientModel {
  final String name;
  final String phone;
  final String email;
  final String address;
  ClientModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  ClientModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? address,
  }) {
    return ClientModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) => ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClientModel(name: $name, phone: $phone, email: $email, address: $address)';
  }

  @override
  bool operator ==(covariant ClientModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.phone == phone &&
      other.email == email &&
      other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      address.hashCode;
  }
}
