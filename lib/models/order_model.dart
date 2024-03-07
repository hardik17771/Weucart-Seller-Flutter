import 'dart:convert';
import 'package:weu_cart_seller/models/address_model.dart';

class OrderModel {
  final int user_id;
  final String userUid;
  final Map<String, dynamic> cart_products;
  final Map<String, dynamic> grocery_cart_products;
  final Map<String, dynamic> cartShopTotalAmount;
  final Map<String, dynamic> groceryCartShopTotalAmount;
  final String customer_name;
  final UserAddressModel customer_current_address;
  final int total_amount;
  final String status;
  final String is_accepted;
  final int order_id;
  final String delivery_time;
  final int item_count;
  final DateTime order_placing_time;
  final DateTime createdAt;
  final DateTime updatedAt;
  OrderModel({
    required this.user_id,
    required this.userUid,
    required this.cart_products,
    required this.grocery_cart_products,
    required this.cartShopTotalAmount,
    required this.groceryCartShopTotalAmount,
    required this.customer_name,
    required this.customer_current_address,
    required this.total_amount,
    required this.status,
    required this.is_accepted,
    required this.order_id,
    required this.delivery_time,
    required this.item_count,
    required this.order_placing_time,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'userUid': userUid,
      'cart_products': cart_products,
      'grocery_cart_products': grocery_cart_products,
      'cartShopTotalAmount': cartShopTotalAmount,
      'groceryCartShopTotalAmount': groceryCartShopTotalAmount,
      'customer_name': customer_name,
      'current_current_address': customer_current_address.toMap(),
      'total_amount': total_amount,
      'status': status,
      'is_accepted': is_accepted,
      'order_id': order_id,
      'delivery_time': delivery_time,
      'item_count': item_count,
      'order_placing_time': order_placing_time.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      user_id: map['user_id'] as int,
      userUid: map['userUid'] as String,
      cart_products: Map<String, dynamic>.from(
          (map['cart_products'] as Map<String, dynamic>)),
      grocery_cart_products: Map<String, dynamic>.from(
          (map['grocery_cart_products'] as Map<String, dynamic>)),
      cartShopTotalAmount: Map<String, dynamic>.from(
          (map['cartShopTotalAmount'] as Map<String, dynamic>)),
      groceryCartShopTotalAmount: Map<String, dynamic>.from(
          (map['groceryCartShopTotalAmount'] as Map<String, dynamic>)),
      customer_name: map['customer_name'] as String,
      customer_current_address:
          UserAddressModel.fromMap(map['customer_current_address'] as dynamic),
      total_amount: map['total_amount'] as int,
      status: map['status'] as String,
      is_accepted: map['is_accepted'] as String,
      order_id: map['order_id'] as int,
      delivery_time: map['delivery_time'] as String,
      item_count: map['item_count'] as int,
      order_placing_time: DateTime.parse(map['order_placing_time'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
