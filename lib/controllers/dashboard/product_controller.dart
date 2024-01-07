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

  Future<ProductModel?> getProductByID({
    required BuildContext context,
    required String productId,
  }) async {
    ProductModel? productModel;

    // To be changed to API Call
    productModel = dummmyProductModel;

    return productModel;
  }
}
