// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../model/product.dart';

class ProductRequest extends Product {
  final int amount;

  ProductRequest({id = 0, name = '', brand = '', type = '', this.amount = 0})
      : super(id: id, name: name, brand: brand, type: type);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'brand': brand,
      'type': type,
      'amount': amount
    };
  }

  factory ProductRequest.fromMap(Map<String, dynamic> map) {
    return ProductRequest(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '').toString(),
      brand: (map['brand'] ?? '').toString(),
      type: (map['type'] ?? '').toString(),
      amount: (map['amount'] ?? 0) as int,
    );
  }
  factory ProductRequest.fromJson(Map<String, dynamic> json) {
    return ProductRequest(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      type: json['type'],
      amount: json['amount'],
    );
  }
}
