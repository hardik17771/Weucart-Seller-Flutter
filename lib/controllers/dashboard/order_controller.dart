import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

class OrderController {
  Future<List<OrderModel>> getShopOrdersByStatus({
    required BuildContext context,
    required ShopModel shopModel,
    required String orderStatus,
  }) async {
    List<OrderModel> currentOrders = [];
    List<OrderModel> pastOrders = [];

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.backendUrl}/api/order-by-shopid"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'shop_id': shopModel.shop_id}),
      );

      var jsonData = json.decode(response.body);
      var status_code = jsonData["status_code"];
      var message = jsonData["message"];

      if (status_code == 200) {
        var dataMap = jsonData['data'].cast<Map<String, dynamic>>();

        // debugPrint(dataMap.toString());

        List<OrderModel> ordersList =
            dataMap.map<OrderModel>((e) => OrderModel.fromMap(e)).toList();

        for (var order in ordersList) {
          if (order.status == "delivered") {
            pastOrders.add(order);
          } else {
            currentOrders.add(order);
          }
        }
      } else {
        debugPrint("Shop Orders $message");
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Internal Server Error",
          message: message,
        );
      }
    } catch (e) {
      debugPrint("Shop Orders $e");
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Internal Server Error",
        message: e.toString(),
      );
    }

    if (orderStatus == "current") {
      return currentOrders;
    } else {
      return pastOrders;
    }
  }

  Future<void> updateOrderAcceptanceStatus({
    required OrderModel orderModel,
    required String isAccepted,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.backendUrl}/api/order-acceptance-status"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'order_id': orderModel.order_id,
          'is_accepted': isAccepted,
        }),
      );

      var jsonData = json.decode(response.body);
      var status_code = jsonData["status_code"];
      var message = jsonData["message"];

      if (status_code == 200) {
        var dataMap = jsonData['data'];

        showToast(text: "Order Acceptance Status Updated");
      } else {
        debugPrint(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateOrderCurrentStatus({
    required OrderModel orderModel,
    required String status,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.backendUrl}/api/upadate-order-status"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'order_id': orderModel.order_id,
          'status': status,
        }),
      );

      var jsonData = json.decode(response.body);
      var status_code = jsonData["status_code"];
      var message = jsonData["message"];

      if (status_code == 200) {
        var dataMap = jsonData['data'];

        showToast(text: "Order Status Updated");
      } else {
        debugPrint(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // ------------------------- POS Orders ---------------------------->

  Future<void> placePOSOrder({
    required BuildContext context,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.backendUrl}/api/place-pos-order"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({}),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData['data'];
        debugPrint(dataMap.toString());
      } else {
        debugPrint(message);
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Order Failed",
          message: message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Order Failed",
        message: e.toString(),
      );
    }
  }
}
