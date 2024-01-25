import 'dart:convert';

class SellerModel {
  final int seller_id;
  final String sellerUid;
  final String name;
  final String phone;
  final String email;
  final String deviceToken;
  final String profileImage;
  final List<Map<String, dynamic>> shops_owned;
  SellerModel({
    required this.seller_id,
    required this.sellerUid,
    required this.name,
    required this.phone,
    required this.email,
    required this.deviceToken,
    required this.profileImage,
    required this.shops_owned,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seller_id': seller_id,
      'sellerUid': sellerUid,
      'name': name,
      'phone': phone,
      'email': email,
      'deviceToken': deviceToken,
      'profileImage': profileImage,
      'shops_owned': shops_owned,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      seller_id: map['seller_id'] as int,
      sellerUid: map['sellerUid'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      deviceToken: map['deviceToken'] as String,
      profileImage: map['profileImage'] as String,
      shops_owned: List<Map<String, dynamic>>.from(
        (map['shops_owned'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
