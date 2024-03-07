import 'dart:convert';

class ShopModel {
  final int seller_id;
  final String? sellerUid;
  final String manager_phone;
  final int shop_id;
  final String name;
  final String email;
  final List<String> shop_images;

  final String latitude;
  final String longitude;
  final String country;
  final String state;
  final String city;
  final String address;
  final String pincode;

  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> sold_products;
  final int no_of_products;
  final String gst_code;
  final bool is_gst_code;
  final int serving_radius;
  final String status;
  final int rating;
  final String deviceToken;
  final List<String> reviews;
  final DateTime opening_time;
  final DateTime closing_time;
  final List<Map<String, dynamic>> categories_list;
  final bool is_delivery_boy;

  final String? logo;
  final String facebook;
  final String google;
  final String twitter;
  final String youtube;
  final String instagram;

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ShopModel({
    required this.seller_id,
    required this.sellerUid,
    required this.manager_phone,
    required this.shop_id,
    required this.name,
    required this.email,
    required this.shop_images,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.pincode,
    required this.products,
    required this.sold_products,
    required this.no_of_products,
    required this.gst_code,
    required this.is_gst_code,
    required this.serving_radius,
    required this.status,
    required this.rating,
    required this.deviceToken,
    required this.reviews,
    required this.opening_time,
    required this.closing_time,
    required this.categories_list,
    required this.is_delivery_boy,
    required this.logo,
    required this.facebook,
    required this.google,
    required this.twitter,
    required this.youtube,
    required this.instagram,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seller_id': seller_id,
      'sellerUid': sellerUid,
      'manager_phone': manager_phone,
      'shop_id': shop_id,
      'name': name,
      'email': email,
      'shop_images': shop_images,
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'state': state,
      'city': city,
      'address': address,
      'pincode': pincode,
      'products': products,
      'sold_products': sold_products,
      'no_of_products': no_of_products,
      'gst_code': gst_code,
      'is_gst_code': is_gst_code,
      'serving_radius': serving_radius,
      'status': status,
      'rating': rating,
      'deviceToken': deviceToken,
      'reviews': reviews,
      'opening_time': opening_time.toIso8601String(),
      'closing_time': closing_time.toIso8601String(),
      'categories_list': categories_list,
      'is_delivery_boy': is_delivery_boy,
      'logo': logo,
      'facebook': facebook,
      'google': google,
      'twitter': twitter,
      'youtube': youtube,
      'instagram': instagram,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      seller_id: map['seller_id'] as int,
      sellerUid: map['sellerUid'] != null ? map['sellerUid'] as String : null,
      manager_phone: map['manager_phone'] as String,
      shop_id: map['shop_id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      shop_images: List<String>.from((map['shop_images'] as List<dynamic>)),
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      pincode: map['pincode'] as String,
      products: List<Map<String, dynamic>>.from(
        (map['products'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
      sold_products: List<Map<String, dynamic>>.from(
        (map['sold_products'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
      no_of_products: map['no_of_products'] as int,
      gst_code: map['gst_code'] as String,
      is_gst_code: map['is_gst_code'] as bool,
      serving_radius: map['serving_radius'] as int,
      status: map['status'] as String,
      rating: map['rating'] as int,
      deviceToken: map['deviceToken'] as String,
      reviews: List<String>.from((map['reviews'] as List<dynamic>)),
      opening_time: DateTime.parse(map['opening_time'] as String),
      closing_time: DateTime.parse(map['closing_time'] as String),
      categories_list: List<Map<String, dynamic>>.from(
        (map['categories_list'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
      is_delivery_boy: map['is_delivery_boy'] as bool,
      logo: map['logo'] != null ? map['logo'] as String : null,
      facebook: map['facebook'] as String,
      google: map['google'] as String,
      twitter: map['twitter'] as String,
      youtube: map['youtube'] as String,
      instagram: map['instagram'] as String,
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

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
