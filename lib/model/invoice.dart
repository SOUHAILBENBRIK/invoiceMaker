// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:quick_invoice/model/client.dart';
import 'package:quick_invoice/model/currency.dart';

class InvoiceModel {
  final String id;
  final ClientModel clientName;
  final String invoiceNumber;
  final String invoiceDate;
  final String invoiceDue;
  final double total;
  final String note;
  final int discount;
  final CountryCurrency currency;
  final List<ItemInvoice> items;
  InvoiceModel({
    required this.id,
    required this.clientName,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.invoiceDue,
    required this.total,
    required this.note,
    required this.discount,
    required this.currency,
    required this.items,
  });

  InvoiceModel copyWith({
    String? id,
    ClientModel? clientName,
    String? invoiceNumber,
    String? invoiceDate,
    String? invoiceDue,
    double? total,
    String? note,
    int? discount,
    CountryCurrency? currency,
    List<ItemInvoice>? items,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      invoiceDue: invoiceDue ?? this.invoiceDue,
      total: total ?? this.total,
      note: note ?? this.note,
      discount: discount ?? this.discount,
      currency: currency ?? this.currency,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clientName': clientName.toMap(),
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate,
      'invoiceDue': invoiceDue,
      'total': total,
      'note': note,
      'discount': discount,
      'currency': currency.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] as String,
      clientName: ClientModel.fromMap(Map<String, dynamic>.from(map['clientName'] as Map)),
      invoiceNumber: map['invoiceNumber'] as String,
      invoiceDate: map['invoiceDate'] as String,
      invoiceDue: map['invoiceDue'] as String,
      total: map['total'] as double,
      note: map['note'] as String,
      discount: map['discount'] as int,
      currency:
          CountryCurrency.fromMap(Map<String, dynamic>.from(map['currency'] as Map)),
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

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceModel(id: $id, clientName: $clientName, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, invoiceDue: $invoiceDue, total: $total, note: $note, discount: $discount, currency: $currency, items: $items)';
  }

  @override
  bool operator ==(covariant InvoiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.clientName == clientName &&
        other.invoiceNumber == invoiceNumber &&
        other.invoiceDate == invoiceDate &&
        other.invoiceDue == invoiceDue &&
        other.total == total &&
        other.note == note &&
        other.discount == discount &&
        other.currency == currency &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientName.hashCode ^
        invoiceNumber.hashCode ^
        invoiceDate.hashCode ^
        invoiceDue.hashCode ^
        total.hashCode ^
        note.hashCode ^
        discount.hashCode ^
        currency.hashCode ^
        items.hashCode;
  }
}

class ItemInvoice {
  final String id;
  final String name;
  final String notes;
  final double price;
  final bool isTaxable;
  final double discount;
  final int count;
  ItemInvoice({
    required this.id,
    required this.name,
    required this.notes,
    required this.price,
    required this.isTaxable,
    required this.discount,
    required this.count,
  });

  ItemInvoice copyWith({
    String? id,
    String? name,
    String? notes,
    double? price,
    bool? isTaxable,
    double? discount,
    int? count,
  }) {
    return ItemInvoice(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      price: price ?? this.price,
      isTaxable: isTaxable ?? this.isTaxable,
      discount: discount ?? this.discount,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'notes': notes,
      'price': price,
      'isTaxable': isTaxable,
      'discount': discount,
      'count': count,
    };
  }

  factory ItemInvoice.fromMap(Map<String, dynamic> map) {
    return ItemInvoice(
      id: map['id'] as String,
      name: map['name'] as String,
      notes: map['notes'] as String,
      price: map['price'] as double,
      isTaxable: map['isTaxable'] as bool,
      discount: map['discount'] as double,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemInvoice.fromJson(String source) =>
      ItemInvoice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemInvoice(id: $id, name: $name, notes: $notes, price: $price, isTaxable: $isTaxable, discount: $discount, count: $count)';
  }

  @override
  bool operator ==(covariant ItemInvoice other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.notes == notes &&
        other.price == price &&
        other.isTaxable == isTaxable &&
        other.discount == discount &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        notes.hashCode ^
        price.hashCode ^
        isTaxable.hashCode ^
        discount.hashCode ^
        count.hashCode;
  }
}
