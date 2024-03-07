import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/order_controller.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/dashboard/shop_analytics/widgets/past_order_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class PastOrdersScreen extends StatefulWidget {
  const PastOrdersScreen({super.key});

  @override
  State<PastOrdersScreen> createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  final ShopController _shopController = ShopController();
  final OrderController _orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryAppBarColor,
        title: Text(
          "Past Orders",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.primaryButtonColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset(
              "assets/images/back_button_icon.svg",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<ShopModel?>(
              future: _shopController.getLocalShopData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ShopModel shopModel = snapshot.data!;
                  return FutureBuilder<List<OrderModel>>(
                    future: _orderController.getShopOrdersByStatus(
                      context: context,
                      shopModel: shopModel,
                      orderStatus: "past",
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<OrderModel> pastOrders = snapshot.data!;
                        if (pastOrders.isEmpty) {
                          return const SizedBox();
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: pastOrders.length,
                            itemBuilder: (BuildContext context, int index) {
                              OrderModel orderModel = pastOrders[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    // Order Details Page
                                  },
                                  child: PastOrderCard(orderModel: orderModel),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return const CustomLoader();
                      }
                    },
                  );
                } else {
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: const CustomLoader(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
