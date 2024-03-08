import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/models/category/main_category_model.dart';
import 'package:weu_cart_seller/models/category/main_sub_category_model.dart';

class CategoryController {
  Future<List<MainCategoryModel>> getMainCategoryList({
    required BuildContext context,
  }) async {
    List<MainCategoryModel> mainCategorys = [];

    try {
      final response = await http.get(
        Uri.parse("${AppConstants.backendUrl}/api/category"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.body.isNotEmpty) {
        var jsonData = json.decode(response.body);
        var statusCode = jsonData["status_code"];
        var message = jsonData["message"];

        if (statusCode == 200) {
          var dataMap = jsonData['list'].cast<Map<String, dynamic>>();

          mainCategorys = dataMap
              .map<MainCategoryModel>((e) => MainCategoryModel.fromMap(e))
              .toList();
        } else {
          debugPrint(message);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return mainCategorys;
  }

  Future<List<MainSubCategoryModel>> getMainSubCategoryList({
    required BuildContext context,
    required MainCategoryModel mainCategoryModel,
  }) async {
    List<MainSubCategoryModel> subCategoriesList = [];

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.backendUrl}/api/main_subcategory"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"category_id": mainCategoryModel.category_id}),
      );

      var jsonData = json.decode(response.body);
      var status_code = jsonData["status_code"];
      var message = jsonData["message"];

      if (status_code == 200) {
        var dataMap = jsonData['data'].cast<Map<String, dynamic>>();
        subCategoriesList = dataMap
            .map<MainSubCategoryModel>((e) => MainSubCategoryModel.fromMap(e))
            .toList();
      } else {
        debugPrint(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return subCategoriesList;
  }
}
