// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:quick_invoice/model/currency.dart';
import 'package:quick_invoice/model/invoice.dart';

class EstimateModel {
  final String id;
  final String estimateNumber;
  final String estimateDate;
  final String estimateDue;
  final double total;
  final String note;
  final int discount;
  final List<ItemInvoice> items;
  final CountryCurrency currency;
  EstimateModel({
    required this.id,
    required this.estimateNumber,
    required this.estimateDate,
    required this.estimateDue,
    required this.total,
    required this.note,
    required this.discount,
    required this.items,
    required this.currency,
  });

  EstimateModel copyWith({
    String? id,
    String? estimateNumber,
    String? estimateDate,
    String? estimateDue,
    double? total,
    String? note,
    int? discount,
    List<ItemInvoice>? items,
    CountryCurrency? currency,
  }) {
    return EstimateModel(
      id: id ?? this.id,
      estimateNumber: estimateNumber ?? this.estimateNumber,
      estimateDate: estimateDate ?? this.estimateDate,
      estimateDue: estimateDue ?? this.estimateDue,
      total: total ?? this.total,
      note: note ?? this.note,
      discount: discount ?? this.discount,
      items: items ?? this.items,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'estimateNumber': estimateNumber,
      'estimateDate': estimateDate,
      'estimateDue': estimateDue,
      'total': total,
      'note': note,
      'discount': discount,
      'items': items.map((x) => x.toMap()).toList(),
      'currency': currency.toMap(),
    };
  }

  factory EstimateModel.fromMap(Map<String, dynamic> map) {
    return EstimateModel(
      id: map['id'] as String,
      estimateNumber: map['estimateNumber'] as String,
      estimateDate: map['estimateDate'] as String,
      estimateDue: map['estimateDue'] as String,
      total: map['total'] as double,
      note: map['note'] as String,
      discount: map['discount'] as int,
      currency: CountryCurrency.fromMap(
          Map<String, dynamic>.from(map['currency'] as Map)),
      items: map['items'] != null
          ? (map['items'] as List<dynamic>).map<ItemInvoice>((item) {
              // Convert each item to Map<String, dynamic>
              return ItemInvoice.fromMap(
                  Map<String, dynamic>.from(item as Map));
            }).toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory EstimateModel.fromJson(String source) =>
      EstimateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EstimateModel(id: $id, estimateNumber: $estimateNumber, estimateDate: $estimateDate, estimateDue: $estimateDue, total: $total, note: $note, discount: $discount, items: $items, currency: $currency)';
  }

  @override
  bool operator ==(covariant EstimateModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.estimateNumber == estimateNumber &&
        other.estimateDate == estimateDate &&
        other.estimateDue == estimateDue &&
        other.total == total &&
        other.note == note &&
        other.discount == discount &&
        listEquals(other.items, items) &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        estimateNumber.hashCode ^
        estimateDate.hashCode ^
        estimateDue.hashCode ^
        total.hashCode ^
        note.hashCode ^
        discount.hashCode ^
        items.hashCode ^
        currency.hashCode;
  }
}
