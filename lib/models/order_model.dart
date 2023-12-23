import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:weu_cart_seller/models/address_model.dart';
import 'package:weu_cart_seller/models/product_model.dart';

class OrderModel {
  // final String customerId
  final String customerName;
  final String customerPhone;
  final UserAddressModel customerAddressModel;
  final String orderAmount;
  final List<ProductModel> products;
  final String orderStatus;
  final DateTime orderDeliveryTime;
  final String paymentMode;
  OrderModel({
    required this.customerName,
    required this.customerPhone,
    required this.customerAddressModel,
    required this.orderAmount,
    required this.products,
    required this.orderStatus,
    required this.orderDeliveryTime,
    required this.paymentMode,
  });

  OrderModel copyWith({
    String? customerName,
    String? customerPhone,
    UserAddressModel? customerAddressModel,
    String? orderAmount,
    List<ProductModel>? products,
    String? orderStatus,
    DateTime? orderDeliveryTime,
    String? paymentMode,
  }) {
    return OrderModel(
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddressModel: customerAddressModel ?? this.customerAddressModel,
      orderAmount: orderAmount ?? this.orderAmount,
      products: products ?? this.products,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDeliveryTime: orderDeliveryTime ?? this.orderDeliveryTime,
      paymentMode: paymentMode ?? this.paymentMode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddressModel': customerAddressModel.toMap(),
      'orderAmount': orderAmount,
      'products': products.map((x) => x.toMap()).toList(),
      'orderStatus': orderStatus,
      'orderDeliveryTime': orderDeliveryTime.millisecondsSinceEpoch,
      'paymentMode': paymentMode,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      customerName: map['customerName'] as String,
      customerPhone: map['customerPhone'] as String,
      customerAddressModel: UserAddressModel.fromMap(
          map['customerAddressModel'] as Map<String, dynamic>),
      orderAmount: map['orderAmount'] as String,
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderStatus: map['orderStatus'] as String,
      orderDeliveryTime:
          DateTime.fromMillisecondsSinceEpoch(map['orderDeliveryTime'] as int),
      paymentMode: map['paymentMode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(customerName: $customerName, customerPhone: $customerPhone, customerAddressModel: $customerAddressModel, orderAmount: $orderAmount, products: $products, orderStatus: $orderStatus, orderDeliveryTime: $orderDeliveryTime, paymentMode: $paymentMode)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.customerName == customerName &&
        other.customerPhone == customerPhone &&
        other.customerAddressModel == customerAddressModel &&
        other.orderAmount == orderAmount &&
        listEquals(other.products, products) &&
        other.orderStatus == orderStatus &&
        other.orderDeliveryTime == orderDeliveryTime &&
        other.paymentMode == paymentMode;
  }

  @override
  int get hashCode {
    return customerName.hashCode ^
        customerPhone.hashCode ^
        customerAddressModel.hashCode ^
        orderAmount.hashCode ^
        products.hashCode ^
        orderStatus.hashCode ^
        orderDeliveryTime.hashCode ^
        paymentMode.hashCode;
  }
}
