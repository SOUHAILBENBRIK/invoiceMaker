// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final String id;
  final String name;
  final String notes;
  final double price;
  final bool isTaxable;
  ItemModel({
    required this.id,
    required this.name,
    required this.notes,
    required this.price,
    required this.isTaxable,
  });

  ItemModel copyWith({
    String? id,
    String? name,
    String? notes,
    double? price,
    bool? isTaxable,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      price: price ?? this.price,
      isTaxable: isTaxable ?? this.isTaxable,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'notes': notes,
      'price': price,
      'isTaxable': isTaxable,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      notes: map['notes'] as String,
      price: map['price'] as double,
      isTaxable: map['isTaxable'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, notes: $notes, price: $price, isTaxable: $isTaxable)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.notes == notes &&
      other.price == price &&
      other.isTaxable == isTaxable;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      notes.hashCode ^
      price.hashCode ^
      isTaxable.hashCode;
  }
}
