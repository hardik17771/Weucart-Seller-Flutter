import 'dart:convert';

class AzureProductModel {
  final int indexx;
  final String product;
  final String category;
  final String sub_category;
  final String brand;
  final sale_price;
  final market_price;
  final String typee;
  final rating;
  final String descriptionn;
  AzureProductModel({
    required this.indexx,
    required this.product,
    required this.category,
    required this.sub_category,
    required this.brand,
    required this.sale_price,
    required this.market_price,
    required this.typee,
    required this.rating,
    required this.descriptionn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'indexx': indexx,
      'product': product,
      'category': category,
      'sub_category': sub_category,
      'brand': brand,
      'sale_price': sale_price,
      'market_price': market_price,
      'typee': typee,
      'rating': rating,
      'descriptionn': descriptionn,
    };
  }

  factory AzureProductModel.fromMap(Map<String, dynamic> map) {
    return AzureProductModel(
      indexx: map['indexx'] as int,
      product: map['product'] as String,
      category: map['category'] as String,
      sub_category: map['sub_category'] as String,
      brand: map['brand'] as String,
      sale_price: map['sale_price'],
      market_price: map['market_price'],
      typee: map['typee'] as String,
      rating: map['rating'],
      descriptionn: map['descriptionn'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AzureProductModel.fromJson(String source) =>
      AzureProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
