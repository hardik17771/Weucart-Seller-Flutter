import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/azure_product_mdoel.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

class ProductController {
  // ------------------------------------- Weucart Products ---------------------------------------->

  Future<List<ProductModel>> getShopProducts({
    required ShopModel shopModel,
  }) async {
    List<ProductModel> products = [];

    products.add(dummmyProductModel);
    products.add(dummmyProductModel);
    products.add(dummmyProductModel);
    products.add(dummmyProductModel);

    return products;
  }

  Future<ProductModel?> getShopProductByISBN({
    required BuildContext context,
    required String productISBN,
  }) async {
    ProductModel? productModel;

    // To be changed to API Call for searching products in this shop
    productModel = dummmyProductModel;

    return productModel;
  }

  Future<ProductModel?> getProductByISBN({
    required BuildContext context,
    required String productISBN,
  }) async {
    ProductModel? productModel;

    try {
      final url = Uri.parse("${AppConstants.backendUrl}/api/product-by-isbn");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'isbn': productISBN}),
      );

      var jsonData = json.decode(response.body);
      var statusCode = jsonData["status_code"];
      var message = jsonData["message"];

      if (statusCode == 200) {
        var dataMap = jsonData["data"];
        if (message != "No Product for the current ISBN") {
          productModel = ProductModel.fromMap(dataMap);
        }
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Internal Server Error",
          message: message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Internal Server Error",
        message: e.toString(),
      );
    }

    return productModel;
  }

  // ------------------------------------ Adding / Creating Product -------------------------------->

  Future<void> addProductToShop({
    required BuildContext context,
    required ProductModel? weucartProductModel,
    required AzureProductModel? azureProductModel,
    required String productISBN,
    required String price,
    required String quantity,
  }) async {
    ShopModel shopModel = await ShopController().getLocalShopData();

    /// Adding Existing WeucartDB Product to this Shop
    if (weucartProductModel != null) {
      try {
        final url =
            Uri.parse("${AppConstants.backendUrl}/api/add-products-to-shop");
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "shop_id": shopModel.shop_id,
            "products": [
              {
                "product_id": weucartProductModel.product_id,
                "quantity": quantity,
                "shop_price": price,
              }
            ]
          }),
        );

        var jsonData = json.decode(response.body);
        var statusCode = jsonData["status_code"];
        var message = jsonData["message"];

        if (statusCode == 200) {
          debugPrint("Product Added to Shop");
          showToast(text: "Product Added to shop");
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
    } else {
      /// Adding Creating New Product in Weucart Product DB from Azure Product
      ProductModel newProductModel = ProductModel(
        product_id: 0,
        name: azureProductModel!.product,
        added_by: "",
        category_id: 2, // currently static
        main_subcategory_id: 4, // currently static
        mrp_price: azureProductModel.market_price.ceil(),
        description: azureProductModel.descriptionn,
        shops: [
          {
            "latitude": shopModel.latitude,
            "longitude": shopModel.longitude,
            "shop_id": shopModel.shop_id,
            "quantity": quantity,
            "shop_price": price,
            "images": []
          }
        ],
        isbn: productISBN,
        unit_price: int.parse(price),
        total_quantity: 0,
        num_of_sale: 0,
        photos: [],
        thumbnail_img: "",
      );

      try {
        final url = Uri.parse("${AppConstants.backendUrl}/api/create-product");
        final response = await http.post(url,
            headers: {"Content-Type": "application/json"},
            body: newProductModel.toJson());

        var jsonData = json.decode(response.body);
        var statusCode = jsonData["status_code"];
        var message = jsonData["message"];

        if (statusCode == 200) {
          debugPrint("Product Created in DB and Added to Shop");

          showToast(text: "Product Added to shop");
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
    }
  }

  // ------------------------------------- Azure Products ---------------------------------------->

  Future<List<AzureProductModel>> searchAzureProductByName({
    required BuildContext context,
    required String query,
  }) async {
    List<AzureProductModel> products = [];

    try {
      final url = Uri.parse(
          "${AppConstants.backendUrl}/secret-database/productsByName");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'product_name': query}),
      );

      var jsonData = json.decode(response.body);
      // var statusCode = jsonData["status_code"];
      // var message = jsonData["message"];

      if (response.statusCode == 200) {
        var dataMap = jsonData.cast<Map<String, dynamic>>();
        debugPrint(dataMap.toString());

        // products = dataMap
        //     .map<AzureProductModel>((e) => AzureProductModel.fromMap(e))
        //     .toList();
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Internal Server Error",
          message: "Unable to fetch the products name suggestions ",
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

    return products;
  }

  Future<AzureProductModel?> searchAzureProductById({
    required BuildContext context,
    required String id,
  }) async {
    AzureProductModel? product;

    return product;
  }

  Future<List<AzureProductModel>> readAllAzureProducts({
    required BuildContext context,
  }) async {
    List<AzureProductModel> products = [];

    return products;
  }
}
