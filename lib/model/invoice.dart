// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class InvoiceModel {
  final String id;
  final String clientNameId;
  final String invoiceNumber;
  final String invoiceDate;
  final String invoiceDue;
  final double total;
  final String note;

  final List<ItemInvoice> items;
  InvoiceModel({
    required this.id,
    required this.clientNameId,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.invoiceDue,
    required this.total,
    required this.note,
    required this.items,
  });

  InvoiceModel copyWith({
    String? id,
    String? clientNameId,
    String? invoiceNumber,
    String? invoiceDate,
    String? invoiceDue,
    double? total,
    String? note,
    List<ItemInvoice>? items,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      clientNameId: clientNameId ?? this.clientNameId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      invoiceDue: invoiceDue ?? this.invoiceDue,
      total: total ?? this.total,
      note: note ?? this.note,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clientNameId': clientNameId,
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate,
      'invoiceDue': invoiceDue,
      'total': total,
      'note': note,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] as String,
      clientNameId: map['clientNameId'] as String,
      invoiceNumber: map['invoiceNumber'] as String,
      invoiceDate: map['invoiceDate'] as String,
      invoiceDue: map['invoiceDue'] as String,
      total: map['total'] as double,
      note: map['note'] as String,
      items: List<ItemInvoice>.from((map['items'] as List<int>).map<ItemInvoice>((x) => ItemInvoice.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceModel(id: $id, clientNameId: $clientNameId, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, invoiceDue: $invoiceDue, total: $total, note: $note, items: $items)';
  }

  @override
  bool operator ==(covariant InvoiceModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.clientNameId == clientNameId &&
      other.invoiceNumber == invoiceNumber &&
      other.invoiceDate == invoiceDate &&
      other.invoiceDue == invoiceDue &&
      other.total == total &&
      other.note == note &&
      listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      clientNameId.hashCode ^
      invoiceNumber.hashCode ^
      invoiceDate.hashCode ^
      invoiceDue.hashCode ^
      total.hashCode ^
      note.hashCode ^
      items.hashCode;
  }
}

class ItemInvoice {
  final String id;
  final double discount;
  final int count;
  ItemInvoice({
    required this.id,
    required this.discount,
    required this.count,
  });

  ItemInvoice copyWith({
    String? id,
    double? discount,
    int? count,
  }) {
    return ItemInvoice(
      id: id ?? this.id,
      discount: discount ?? this.discount,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'discount': discount,
      'count': count,
    };
  }

  factory ItemInvoice.fromMap(Map<String, dynamic> map) {
    return ItemInvoice(
      id: map['id'] as String,
      discount: map['discount'] as double,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemInvoice.fromJson(String source) =>
      ItemInvoice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemInvoice(id: $id, discount: $discount, count: $count)';

  @override
  bool operator ==(covariant ItemInvoice other) {
    if (identical(this, other)) return true;

    return other.id == id && other.discount == discount && other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ discount.hashCode ^ count.hashCode;
}
