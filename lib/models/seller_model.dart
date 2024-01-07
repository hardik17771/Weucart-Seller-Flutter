import 'dart:convert';

class SellerModel {
  final String sellerId;
  final String sellerUid;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final List<String> shops;
  SellerModel({
    required this.sellerId,
    required this.sellerUid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.shops,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sellerId': sellerId,
      'sellerUid': sellerUid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'shops': shops,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      sellerId: map['sellerId'] as String,
      sellerUid: map['sellerUid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profileImage: map['profileImage'] as String,
      shops: List<String>.from((map['shops'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
