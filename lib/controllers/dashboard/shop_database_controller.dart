import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/product/pos_product_model.dart';
import 'package:weu_cart_seller/models/product/product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

class ShopDatabaseController {
  //----------------------- Product ----------------------------->

  Future<List<ProductModel>> getShopProducts({
    required ShopModel shopModel,
  }) async {
    List<ProductModel> shopProductsList = [];

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.backendUrl}/api/shop-products"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'shop_id': shopModel.shop_id}),
      );

      var jsonData = json.decode(response.body);
      var status_code = jsonData["status_code"];
      var message = jsonData["message"];

      if (status_code == 200) {
        var dataMap = jsonData['data'].cast<Map<String, dynamic>>();

        shopProductsList =
            dataMap.map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
      } else {
        debugPrint(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return shopProductsList;
  }

  Future<bool> updateShopProductData({
    required BuildContext context,
    required ShopModel shopModel,
    required int productId,
    required int updatedQuantity,
    required int updatedPrice,
  }) async {
    bool isUpdated = false;
    try {
      final url =
          Uri.parse("${AppConstants.backendUrl}/api/update-products-of-shop");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "shop_id": shopModel.shop_id,
          "products": [
            {
              "product_id": productId,
              "quantity": updatedQuantity,
              "shop_price": updatedPrice,
            }
          ]
        }),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        isUpdated = true;
        debugPrint("Product Data Updated");
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Internal Server Error",
          message: message,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Internal Server Error",
        message: e.toString(),
      );
    }

    return isUpdated;
  }

  // -------------------- POS ----------------------------------->

  Future<POSProductModel?> getShopProductByISBN({
    required BuildContext context,
    required int shopId,
    required String productISBN,
  }) async {
    POSProductModel? posProductModel;

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.backendUrl}/api/product-by-isbn-shop"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "shop_id": shopId,
          "isbn": productISBN,
        }),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData['data'];
        ProductModel productModel = ProductModel.fromMap(dataMap);

        Map<String, dynamic> currentShopData = getCurrentShopProductData(
          shops: productModel.shops,
          shopId: shopId,
        );

        posProductModel = POSProductModel(
          product_id: productModel.product_id,
          isbn: productModel.isbn,
          name: productModel.name,
          description: productModel.description,
          category_id: productModel.category_id,
          main_subcategory_id: productModel.main_subcategory_id,
          brand_id: productModel.brand_id,
          quantity: 1, // initially
          num_of_sale: productModel.num_of_sale,
          photos: productModel.photos,
          thumbnail_img: productModel.thumbnail_img,
          unit_price: currentShopData["shop_price"],
          mrp_price: productModel.mrp_price,
          rating: productModel.rating,
        );
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Internal Server Error",
          message: message,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Internal Server Error",
        message: e.toString(),
      );
    }

    return posProductModel;
  }

  Map<String, dynamic> getCurrentShopProductData({
    required List<Map<String, dynamic>> shops,
    required int shopId,
  }) {
    debugPrint(shops.toString());
    Map<String, dynamic> shopData = {};
    for (var currentShopData in shops) {
      if (currentShopData["shop_id"] == shopId) {
        shopData = currentShopData;
        break;
      }
    }
    return shopData;
  }
}
