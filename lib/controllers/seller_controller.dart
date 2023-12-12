import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/dashboard/dashboard_screen.dart';

class ShopController {
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
      var status = jsonData["status"];
      var message = jsonData["message"];

      if (status == "1") {
        var dataMap = jsonData['user'].cast<Map<String, dynamic>>();
        recievedShopModel = ShopModel.fromMap(dataMap);

        await saveLocalShopData(shopModel: shopModel);

        showToast(text: "User Profile Created");

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const DashboardScreen(pageIndex: 0);
            },
          ),
          (route) => false,
        );
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, text: message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<void> updateShopData({
    required ShopModel shopModel,
    required BuildContext context,
  }) async {
    try {
      ShopModel recievedUserModel;
      final url = Uri.parse("${AppConstants.backendUrl}/api/update-shop");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: shopModel.toJson(),
      );

      var jsonData = json.decode(response.body);
      var status = jsonData["status"];
      var message = jsonData["message"];

      if (status == "1") {
        var dataMap = jsonData['user'].cast<Map<String, dynamic>>();
        recievedUserModel = ShopModel.fromMap(dataMap);

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
    required BuildContext context,
    required String shop_uid,
  }) async {
    ShopModel? recievedShopModel;
    try {
      final url = Uri.parse("${AppConstants.backendUrl}/api/update-shop");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'shop_uid': shop_uid}),
      );

      var jsonData = json.decode(response.body);
      var status = jsonData["status"];
      var message = jsonData["message"];

      if (status == "1") {
        var dataMap = jsonData['user'].cast<Map<String, dynamic>>();
        recievedShopModel = ShopModel.fromMap(dataMap);

        // save to Local Storage
        await saveLocalShopData(shopModel: recievedShopModel);
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, text: message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: e.toString());
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
