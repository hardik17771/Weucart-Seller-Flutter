import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weu_cart_seller/controllers/seller_controller.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/auth/shop/seller_shop_dashboard_screen.dart';

class ShopController {
  final SellerController _sellerController = SellerController();
  // ------------------------- User - CRUD in db ------------------------>

  Future<void> createShopData({
    required ShopModel shopModel,
    required BuildContext context,
  }) async {
    try {
      ShopModel recievedShopModel;
      final url = Uri.parse("${AppConstants.backendUrl}/api/create-shop");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: shopModel.toJson(),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      debugPrint(response.body.toString());

      if (statusCode == 200) {
        var dataMap = jsonData['data'];
        recievedShopModel = ShopModel.fromMap(dataMap);

        showToast(text: "Shop Created");

        /// --- This time we are fetching sellerModel to update the localSellerData ---->

        // ignore: use_build_context_synchronously
        await _sellerController.readSellerData(
          sellerUid: recievedShopModel.sellerUid,
          context: context,
        );

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const SellerShopDashboardScreen();
            },
          ),
          (route) => false,
        );
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Registration Error",
          message: message,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Registration Error",
        message: e.toString(),
      );

      debugPrint(e.toString());
    }
  }

  // Testing Remain
  Future<void> updateShopData({
    required ShopModel shopModel,
    required BuildContext context,
  }) async {
    try {
      ShopModel recievedShopModel;
      final url = Uri.parse("${AppConstants.backendUrl}/api/update-shop");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: shopModel.toJson(),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData['shop'];
        recievedShopModel = ShopModel.fromMap(dataMap);

        await saveLocalShopData(shopModel: shopModel);

        showToast(text: "Shop Profile Updated");
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, text: message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<ShopModel?> readShopData({
    required String shopId,
  }) async {
    ShopModel? recievedShopModel;
    try {
      final url = Uri.parse("${AppConstants.backendUrl}/api/shop-details");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'shop_id': shopId}),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData['data'];
        recievedShopModel = ShopModel.fromMap(dataMap);
      } else {
        debugPrint(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return recievedShopModel;
  }

  // -------------------------- User CRUD in shared preferences ------------>

  Future<bool> checkLocalShopDataExistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString("shopModel") != null);
  }

  Future<void> saveLocalShopData({required ShopModel shopModel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("shopModel", shopModel.toJson());
  }

  Future<ShopModel> getLocalShopData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var modelJson = prefs.getString("shopModel");
    ShopModel model = ShopModel.fromJson(modelJson!);
    return model;
  }

  Future<void> removeLocalShopData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("shopModel");
  }
}
