import 'package:flutter/widgets.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

class ProductController {
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

    // To be changed to API Call
    productModel = dummmyProductModel;

    return productModel;
  }

  Future<List<ProductModel>> searchProductByName({
    required BuildContext context,
    required String query,
  }) async {
    List<ProductModel> products = [];

    products.add(dummmyProductModel);
    products.add(dummmyProductModel);

    return products;
  }
}
