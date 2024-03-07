import 'dart:convert';

class ProductModel {
  final int product_id;
  final String name;
  final String added_by;
  final int category_id;
  final int main_subcategory_id;
  final List<Map<String, dynamic>> shops;
  final String isbn;
  final String description;
  final int total_quantity;
  final int num_of_sale;
  final String? brand_id;
  final List<String> photos;
  final String thumbnail_img;
  final int unit_price;
  final int mrp_price;
  final List<String> reviews;
  final String? rating;
  final Map<String, dynamic> shop_with_least_price;
  final Map<String, dynamic> shop_with_second_least_price;
  final Map<String, dynamic> shop_with_maximum_quantity;

  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ProductModel({
    required this.product_id,
    required this.name,
    required this.added_by,
    required this.category_id,
    required this.main_subcategory_id,
    required this.shops,
    required this.isbn,
    required this.description,
    required this.total_quantity,
    required this.num_of_sale,
    this.brand_id,
    required this.photos,
    required this.thumbnail_img,
    required this.unit_price,
    required this.mrp_price,
    required this.reviews,
    this.rating,
    required this.shop_with_least_price,
    required this.shop_with_second_least_price,
    required this.shop_with_maximum_quantity,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': product_id,
      'name': name,
      'added_by': added_by,
      'category_id': category_id,
      'main_subcategory_id': main_subcategory_id,
      'shops': shops,
      'isbn': isbn,
      'description': description,
      'total_quantity': total_quantity,
      'num_of_sale': num_of_sale,
      'brand_id': brand_id,
      'photos': photos,
      'thumbnail_img': thumbnail_img,
      'unit_price': unit_price,
      'mrp_price': mrp_price,
      'rating': rating,
      'reviews': reviews,
      'shop_with_least_price': shop_with_least_price,
      'shop_with_second_least_price': shop_with_second_least_price,
      'shop_with_maximum_quantity': shop_with_maximum_quantity,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      product_id: map['product_id'] as int,
      name: map['name'] as String,
      added_by: map['added_by'] as String,
      category_id: map['category_id'] as int,
      main_subcategory_id: map['main_subcategory_id'] as int,
      shops: List<Map<String, dynamic>>.from(
        (map['shops'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ).toList(),
      isbn: map['isbn'] as String,
      description: map['description'] as String,
      total_quantity: map['total_quantity'] as int,
      num_of_sale: map['num_of_sale'] as int,
      brand_id: map['brand_id'] != null ? map['brand_id'] as String : null,
      photos: List<String>.from((map['photos'] as List<dynamic>)),
      thumbnail_img: map['thumbnail_img'] as String,
      unit_price: map['unit_price'] as int,
      mrp_price: map['mrp_price'] as int,
      rating: (map['rating'] != null) ? (map['rating'] as String) : null,
      reviews: List<String>.from((map['reviews'] as List<dynamic>)),
      shop_with_least_price: Map<String, dynamic>.from(
        map['shop_with_least_price'] as Map<String, dynamic>,
      ),
      shop_with_second_least_price: Map<String, dynamic>.from(
        map['shop_with_second_least_price'] as Map<String, dynamic>,
      ),
      shop_with_maximum_quantity: Map<String, dynamic>.from(
        map['shop_with_maximum_quantity'] as Map<String, dynamic>,
      ),
      id: map['_id'] != null ? map['_id'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      v: map['__v'] != null ? map['__v'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
