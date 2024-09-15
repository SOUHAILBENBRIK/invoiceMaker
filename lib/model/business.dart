// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';  // Correct import for Uint8List

class Business {
  final String name;
  final String? userName;
  final String? description;
  final String? address;
  final String? phone;
  final String? email;
  final Uint8List? image;

  Business({
    required this.name,
    this.userName,
    this.description,
    this.address,
    this.phone,
    this.email,
    this.image,
  });

  Business copyWith({
    String? name,
    String? userName,
    String? description,
    String? address,
    String? phone,
    String? email,
    Uint8List? image,
  }) {
    return Business(
      name: name ?? this.name,
      userName: userName ?? this.userName,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userName': userName,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      // Encode image as base64 string
      'image': image != null ? base64Encode(image!) : null,
    };
  }

  factory Business.fromMap(Map<String, dynamic> map) {
    return Business(
      name: map['name'] as String,
      userName: map['userName'] != null ? map['userName'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      // Decode base64 string back to Uint8List
      image: map['image'] != null ? base64Decode(map['image'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Business.fromJson(String source) =>
      Business.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Business(name: $name, userName: $userName, description: $description, address: $address, phone: $phone, email: $email, image: $image)';
  }

  @override
  bool operator ==(covariant Business other) {
    if (identical(this, other)) return true;

    return 
      other.name == name &&
      other.userName == userName &&
      other.description == description &&
      other.address == address &&
      other.phone == phone &&
      other.email == email &&
      other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      userName.hashCode ^
      description.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      image.hashCode;
  }
}
