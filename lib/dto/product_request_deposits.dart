import '../model/product.dart';

class ProductRequestDeposits extends Product {
  final List<DepositProduct> depositos;

  ProductRequestDeposits(
    int id,
    String name,
    String brand,
    String type,
    this.depositos,
  ) : super(id: id, name: name, brand: brand, type: type);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'brand': brand,
      'type': type,
      'depositos': depositos.map((deposito) => deposito.toMap()).toList()
    };
  }
}

class DepositProduct {
  final String name;
  final int amount;
  DepositProduct({
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'amount': amount};
  }

  factory DepositProduct.fromJson(Map<String, dynamic> json) {
    return DepositProduct(
      name: json['name'],
      amount: json['amount'],
    );
  }
}
