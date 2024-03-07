import 'dart:convert';
import 'package:flutter/foundation.dart';

class MainSubCategoryModel {
  final String id;
  final String name;
  final int category_id;
  final List<String> productIds;
  final String createdAt;
  final String updatedAt;
  final int main_subcategory_id;
  final int v;

  MainSubCategoryModel({
    required this.id,
    required this.name,
    required this.category_id,
    required this.productIds,
    required this.createdAt,
    required this.updatedAt,
    required this.main_subcategory_id,
    required this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'category_id': category_id,
      'products': productIds,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'main_subcategory_id': main_subcategory_id,
      '__v': v,
    };
  }

  factory MainSubCategoryModel.fromMap(Map<String, dynamic> map) {
    return MainSubCategoryModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      category_id: map['category_id'] as int,
      productIds: List<String>.from((map['products'] as List<dynamic>)),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      main_subcategory_id: map['main_subcategory_id'] as int,
      v: map['__v'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MainSubCategoryModel.fromJson(String source) =>
      MainSubCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant MainSubCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.category_id == category_id &&
        listEquals(other.productIds, productIds) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.main_subcategory_id == main_subcategory_id &&
        other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        category_id.hashCode ^
        productIds.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        main_subcategory_id.hashCode ^
        v.hashCode;
  }
}
