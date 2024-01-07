import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

class OrderController {
  Future<List<OrderModel>> getLiveOrders({required ShopModel shopModel}) async {
    List<OrderModel> ordersList = [];

    ordersList.add(dummyOrderModel);
    ordersList.add(dummyOrderModel);

    return ordersList;
  }

  Future<List<OrderModel>> getPastOrders({required ShopModel shopModel}) async {
    List<OrderModel> ordersList = [];

    /// Refected + Delivered
    ordersList.add(dummyOrderModel);
    ordersList.add(dummyOrderModel);
    ordersList.add(dummyOrderModel);

    return ordersList;
  }
}
