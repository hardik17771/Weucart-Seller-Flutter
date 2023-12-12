import 'dart:convert';

class ShopModel {
  final int shopId;
  final String shopUid;
  final List<String> categoryId;
  final String name;
  final String ownerName;
  final String phoneNumber;
  final String emailId;
  final String logo;
  final String image;
  final String address;
  final String city;
  final String pincode;
  final String latitude;
  final String longitude;
  final String rating;
  final String deliveryTime;
  final String onlineStatus;
  final String deviceToken;
  ShopModel({
    required this.shopId,
    required this.shopUid,
    required this.categoryId,
    required this.name,
    required this.ownerName,
    required this.phoneNumber,
    required this.emailId,
    required this.logo,
    required this.image,
    required this.address,
    required this.city,
    required this.pincode,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.deliveryTime,
    required this.onlineStatus,
    required this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopId': shopId,
      'shopUid': shopUid,
      'categoryId': categoryId,
      'name': name,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'emailId': emailId,
      'logo': logo,
      'image': image,
      'address': address,
      'city': city,
      'pincode': pincode,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'deliveryTime': deliveryTime,
      'onlineStatus': onlineStatus,
      'deviceToken': deviceToken,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      shopId: map['shopId'] as int,
      shopUid: map['shopUid'] as String,
      categoryId: List<String>.from((map['categoryId'] as List<dynamic>)),
      name: map['name'] as String,
      ownerName: map['ownerName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      emailId: map['emailId'] as String,
      logo: map['logo'] as String,
      image: map['image'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      pincode: map['pincode'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      rating: map['rating'] as String,
      deliveryTime: map['deliveryTime'] as String,
      onlineStatus: map['onlineStatus'] as String,
      deviceToken: map['deviceToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
