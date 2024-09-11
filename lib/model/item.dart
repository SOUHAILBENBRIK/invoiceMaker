// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final String name;
  final String notes;
  final double price;
  ItemModel({
    required this.name,
    required this.notes,
    required this.price,
  });

  ItemModel copyWith({
    String? name,
    String? notes,
    double? price,
  }) {
    return ItemModel(
      name: name ?? this.name,
      notes: notes ?? this.notes,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'notes': notes,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] as String,
      notes: map['notes'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ItemModel(name: $name, notes: $notes, price: $price)';

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.notes == notes &&
      other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ notes.hashCode ^ price.hashCode;
}
