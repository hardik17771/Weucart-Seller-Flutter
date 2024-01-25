import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/seller_model.dart';
import 'package:weu_cart_seller/views/auth/shop/seller_shop_dashboard_screen.dart';
import 'package:weu_cart_seller/views/auth/splash_screen.dart';

class SellerController {
  // ------------------------- Seller - CRUD in db ------------------------>

  Future<void> createSellerData({
    required SellerModel sellerModel,
    required BuildContext context,
  }) async {
    try {
      SellerModel recievedSellerModel;
      final url = Uri.parse("${AppConstants.backendUrl}/api/create-seller");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: sellerModel.toJson(),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData['data'];
        recievedSellerModel = SellerModel.fromMap(dataMap);

        await saveLocalSellerData(sellerModel: recievedSellerModel);

        showToast(text: "Seller Profile Created");

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
    }
  }

  // Testeing remain
  Future<void> updateSellerData({
    required SellerModel sellerModel,
    required BuildContext context,
  }) async {
    try {
      SellerModel recievedSellerModel;
      final url = Uri.parse("${AppConstants.backendUrl}/api/update-seller");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: sellerModel.toJson(),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData['seller'];
        recievedSellerModel = SellerModel.fromMap(dataMap);

        await saveLocalSellerData(sellerModel: sellerModel);

        showToast(text: "Seller Profile Updated");

        // ignore: use_build_context_synchronously
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return const DashboardScreen(pageIndex: 0);
        //     },
        //   ),
        //   (route) => false,
        // );
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, text: message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<SellerModel?> readSellerData({
    required String sellerUid,
    required BuildContext context,
  }) async {
    SellerModel? recievedSellerModel;
    try {
      final url = Uri.parse("${AppConstants.backendUrl}/api/seller-details");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'sellerUid': sellerUid}),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData['data'];
        recievedSellerModel = SellerModel.fromMap(dataMap);

        // save to Local Storage
        await saveLocalSellerData(sellerModel: recievedSellerModel);
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
    }

    return recievedSellerModel;
  }

  // --------------------- Seller - CRUD in shared preferences -------------->

  Future<bool> checkLocalSellerDataExistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString("sellerModel") != null);
  }

  Future<void> saveLocalSellerData({required SellerModel sellerModel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("sellerModel", sellerModel.toJson());
  }

  Future<SellerModel> getLocalSellerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var modelJson = prefs.getString("sellerModel");
    SellerModel model = SellerModel.fromJson(modelJson!);
    return model;
  }

  Future<void> removeLocalSellerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("sellerModel");
  }

  // --------------------- Seller Logout -------------->

  Future<void> logOut({
    required BuildContext context,
  }) async {
    try {
      await removeLocalSellerData();
      await FirebaseAuth.instance.signOut();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        ),
        (route) => false,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context: context,
        text: e.toString(),
      );
    }
  }
}
