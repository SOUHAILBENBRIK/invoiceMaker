// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:quick_invoice/model/currency.dart';
import 'package:quick_invoice/model/invoice.dart';

class EstimateModel {
  final String id;
  final String invoiceNumber;
  final String invoiceDate;
  final String invoiceDue;
  final double total;
  final String note;
  final int discount;
  final List<ItemInvoice> items;
  final CountryCurrency currency;
  EstimateModel({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.invoiceDue,
    required this.total,
    required this.note,
    required this.discount,
    required this.items,
    required this.currency,
  });

  EstimateModel copyWith({
    String? id,
    String? invoiceNumber,
    String? invoiceDate,
    String? invoiceDue,
    double? total,
    String? note,
    int? discount,
    List<ItemInvoice>? items,
    CountryCurrency? currency,
  }) {
    return EstimateModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      invoiceDue: invoiceDue ?? this.invoiceDue,
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
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate,
      'invoiceDue': invoiceDue,
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
      invoiceNumber: map['invoiceNumber'] as String,
      invoiceDate: map['invoiceDate'] as String,
      invoiceDue: map['invoiceDue'] as String,
      total: map['total'] as double,
      note: map['note'] as String,
      discount: map['discount'] as int,
      items: map['items'] != null 
      ? (map['items'] as List<dynamic>).map<ItemInvoice>((item) {
          // Convert each item to Map<String, dynamic>
          return ItemInvoice.fromMap(Map<String, dynamic>.from(item as Map));
        }).toList() 
      : [],
      currency: CountryCurrency.fromMap(map['currency'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory EstimateModel.fromJson(String source) =>
      EstimateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EstimateModel(id: $id, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, invoiceDue: $invoiceDue, total: $total, note: $note, discount: $discount, items: $items, currency: $currency)';
  }

  @override
  bool operator ==(covariant EstimateModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.invoiceNumber == invoiceNumber &&
        other.invoiceDate == invoiceDate &&
        other.invoiceDue == invoiceDue &&
        other.total == total &&
        other.note == note &&
        other.discount == discount &&
        listEquals(other.items, items) &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        invoiceNumber.hashCode ^
        invoiceDate.hashCode ^
        invoiceDue.hashCode ^
        total.hashCode ^
        note.hashCode ^
        discount.hashCode ^
        items.hashCode ^
        currency.hashCode;
  }
}
