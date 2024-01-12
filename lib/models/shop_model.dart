import 'dart:convert';
import 'package:weu_cart_seller/models/address_model.dart';

class ShopModel {
  final String shopId;
  final String shopUid;
  final String shopName;
  final String sellerId;
  final String sellerUid;
  final String sellerName;
  final String phoneNumber;
  final String emailId;
  final String gstCode;
  final String logo;
  final String image;
  final List<String> categoryId;
  final UserAddressModel addressModel;
  final DateTime openingTime;
  final DateTime closingTime;
  final String deliveryTime;
  final String onlineStatus;
  final String rating;
  final String deviceToken;
  ShopModel({
    required this.shopId,
    required this.shopUid,
    required this.shopName,
    required this.sellerId,
    required this.sellerUid,
    required this.sellerName,
    required this.phoneNumber,
    required this.emailId,
    required this.gstCode,
    required this.logo,
    required this.image,
    required this.categoryId,
    required this.addressModel,
    required this.openingTime,
    required this.closingTime,
    required this.deliveryTime,
    required this.onlineStatus,
    required this.rating,
    required this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopId': shopId,
      'shopUid': shopUid,
      'shopName': shopName,
      'sellerId': sellerId,
      'sellerUid': sellerUid,
      'sellerName': sellerName,
      'phoneNumber': phoneNumber,
      'emailId': emailId,
      'gstCode': gstCode,
      'logo': logo,
      'image': image,
      'categoryId': categoryId,
      'addressModel': addressModel.toMap(),
      'openingTime': openingTime.millisecondsSinceEpoch,
      'closingTime': closingTime.millisecondsSinceEpoch,
      'deliveryTime': deliveryTime,
      'onlineStatus': onlineStatus,
      'rating': rating,
      'deviceToken': deviceToken,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      shopId: map['shopId'] as String,
      shopUid: map['shopUid'] as String,
      shopName: map['shopName'] as String,
      sellerId: map['sellerId'] as String,
      sellerUid: map['sellerUid'] as String,
      sellerName: map['sellerName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      emailId: map['emailId'] as String,
      gstCode: map['gstCode'] as String,
      logo: map['logo'] as String,
      image: map['image'] as String,
      categoryId: List<String>.from((map['categoryId'] as List<dynamic>)),
      addressModel:
          UserAddressModel.fromMap(map['addressModel'] as Map<String, dynamic>),
      openingTime:
          DateTime.fromMillisecondsSinceEpoch(map['openingTime'] as int),
      closingTime:
          DateTime.fromMillisecondsSinceEpoch(map['closingTime'] as int),
      deliveryTime: map['deliveryTime'] as String,
      onlineStatus: map['onlineStatus'] as String,
      rating: map['rating'] as String,
      deviceToken: map['deviceToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
