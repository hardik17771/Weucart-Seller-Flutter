import 'dart:convert';
import 'package:flutter/foundation.dart';

class POSProductModel {
  final int product_id;
  final String isbn;
  final String name;
  final String description;
  final int category_id;
  final int main_subcategory_id;
  final String? brand_id;
  int quantity;
  final int num_of_sale;
  final String thumbnail_img;
  final List<String> photos;
  final int unit_price;
  final int mrp_price;
  final String? rating;
  POSProductModel({
    required this.product_id,
    required this.isbn,
    required this.name,
    required this.description,
    required this.category_id,
    required this.main_subcategory_id,
    this.brand_id,
    required this.quantity,
    required this.num_of_sale,
    required this.thumbnail_img,
    required this.photos,
    required this.unit_price,
    required this.mrp_price,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': product_id,
      'isbn': isbn,
      'name': name,
      'description': description,
      'category_id': category_id,
      'main_subcategory_id': main_subcategory_id,
      'brand_id': brand_id,
      'quantity': quantity,
      'num_of_sale': num_of_sale,
      'thumbnail_img': thumbnail_img,
      'photos': photos,
      'unit_price': unit_price,
      'mrp_price': mrp_price,
      'rating': rating,
    };
  }

  factory POSProductModel.fromMap(Map<String, dynamic> map) {
    return POSProductModel(
      product_id: map['product_id'] as int,
      isbn: map['isbn'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category_id: map['category_id'] as int,
      main_subcategory_id: map['main_subcategory_id'] as int,
      brand_id: map['brand_id'] != null ? map['brand_id'] as String : null,
      quantity: map['quantity'] as int,
      num_of_sale: map['num_of_sale'] as int,
      thumbnail_img: map['thumbnail_img'] as String,
      photos: List<String>.from((map['photos'] as List<dynamic>)),
      unit_price: map['unit_price'] as int,
      mrp_price: map['mrp_price'] as int,
      rating: map['rating'] != null ? map['rating'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory POSProductModel.fromJson(String source) =>
      POSProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant POSProductModel other) {
    if (identical(this, other)) return true;

    return other.product_id == product_id &&
        other.isbn == isbn &&
        other.name == name &&
        other.description == description &&
        other.category_id == category_id &&
        other.main_subcategory_id == main_subcategory_id &&
        other.brand_id == brand_id &&
        other.quantity == quantity &&
        other.num_of_sale == num_of_sale &&
        other.thumbnail_img == thumbnail_img &&
        listEquals(other.photos, photos) &&
        other.unit_price == unit_price &&
        other.mrp_price == mrp_price &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return product_id.hashCode ^
        isbn.hashCode ^
        name.hashCode ^
        description.hashCode ^
        category_id.hashCode ^
        main_subcategory_id.hashCode ^
        brand_id.hashCode ^
        quantity.hashCode ^
        num_of_sale.hashCode ^
        thumbnail_img.hashCode ^
        photos.hashCode ^
        unit_price.hashCode ^
        mrp_price.hashCode ^
        rating.hashCode;
  }
}
