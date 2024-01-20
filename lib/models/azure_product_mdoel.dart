import 'dart:convert';

class AzureProductModel {
  final String name;
  final String product_id;
  AzureProductModel({
    required this.name,
    required this.product_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'product_id': product_id,
    };
  }

  factory AzureProductModel.fromMap(Map<String, dynamic> map) {
    return AzureProductModel(
      name: map['name'] as String,
      product_id: map['product_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AzureProductModel.fromJson(String source) =>
      AzureProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
