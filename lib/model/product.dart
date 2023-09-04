// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String brand;
  final String type;
  
  Product({
    this.id = 0,
    this.name = '',
    this.brand = '',
    this.type = '',
  });

  Product copyWith({
    int? id,
    String? name,
    String? brand,
    String? type,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      type: type ?? this.type,
    );
  }

  bool isEmpty() {
    if (name.isEmpty && brand.isEmpty && type.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'brand': brand,
      'type': type,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '').toString(),
      brand: (map['brand'] ?? '').toString(),
      type: (map['type'] ?? '').toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, brand: $brand, type: $type)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.brand == brand &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ brand.hashCode ^ type.hashCode;
  }
}
