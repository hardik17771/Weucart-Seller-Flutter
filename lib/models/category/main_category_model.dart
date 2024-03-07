import 'dart:convert';

import 'package:flutter/foundation.dart';

class MainCategoryModel {
  final int category_id;
  final String name;
  final String banner;
  final String icon;
  final String image;
  final int featured;
  final int top;
  final List<String> subCategoryIdsList;
  final List<String> productIdsList;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  MainCategoryModel({
    required this.category_id,
    required this.name,
    required this.banner,
    required this.icon,
    required this.image,
    required this.featured,
    required this.top,
    required this.subCategoryIdsList,
    required this.productIdsList,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category_id': category_id,
      'name': name,
      'banner': banner,
      'icon': icon,
      'image': image,
      'featured': featured,
      'top': top,
      'subCategories': subCategoryIdsList,
      'products': productIdsList,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }

  factory MainCategoryModel.fromMap(Map<String, dynamic> map) {
    return MainCategoryModel(
      category_id: map['category_id'] as int,
      name: map['name'] as String,
      banner: map['banner'] as String,
      icon: map['icon'] as String,
      image: map['image'] as String,
      featured: map['featured'] as int,
      top: map['top'] as int,
      subCategoryIdsList:
          List<String>.from((map['subCategories'] as List<dynamic>)),
      productIdsList: List<String>.from((map['products'] as List<dynamic>)),
      id: map['_id'] != null ? map['_id'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      v: map['__v'] != null ? map['__v'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MainCategoryModel.fromJson(String source) =>
      MainCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant MainCategoryModel other) {
    if (identical(this, other)) return true;

    return other.category_id == category_id &&
        other.name == name &&
        other.banner == banner &&
        other.icon == icon &&
        other.image == image &&
        other.featured == featured &&
        other.top == top &&
        listEquals(other.subCategoryIdsList, subCategoryIdsList) &&
        listEquals(other.productIdsList, productIdsList) &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode {
    return category_id.hashCode ^
        name.hashCode ^
        banner.hashCode ^
        icon.hashCode ^
        image.hashCode ^
        featured.hashCode ^
        top.hashCode ^
        subCategoryIdsList.hashCode ^
        productIdsList.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        v.hashCode;
  }
}
