import 'dart:convert';

class UserAddressModel {
  final int address_id;
  final String latitude;
  final String longitude;
  final String address;
  final String city;
  final String state;
  final String country;
  final String pincode;

  final String? userUid;
  final String? user_id;
  final String? id;
  final String? v;
  UserAddressModel({
    required this.address_id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    this.userUid,
    this.user_id,
    this.id,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_id': address_id,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'userUid': userUid,
      'user_id': user_id,
      '_id': id,
      '__v': v,
    };
  }

  factory UserAddressModel.fromMap(Map<String, dynamic> map) {
    return UserAddressModel(
      address_id: map['address_id'] as int,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      pincode: map['pincode'] as String,
      userUid: map['userUid'] != null ? map['userUid'] as String : null,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      id: map['_id'] != null ? map['_id'] as String : null,
      v: map['__v'] != null ? map['__v'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddressModel.fromJson(String source) =>
      UserAddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserAddressModel other) {
    if (identical(this, other)) return true;

    return other.address_id == address_id &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.pincode == pincode &&
        other.userUid == userUid &&
        other.user_id == user_id &&
        other.id == id &&
        other.v == v;
  }

  @override
  int get hashCode {
    return address_id.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        pincode.hashCode ^
        userUid.hashCode ^
        user_id.hashCode ^
        id.hashCode ^
        v.hashCode;
  }
}
