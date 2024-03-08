import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/order_controller.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/dashboard/orders/order_details_screen.dart';
import 'package:weu_cart_seller/views/dashboard/orders/widgets/order_history_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class ShopAnalyticsScreen extends StatefulWidget {
  const ShopAnalyticsScreen({super.key});

  @override
  State<ShopAnalyticsScreen> createState() => _ShopAnalyticsScreenState();
}

class _ShopAnalyticsScreenState extends State<ShopAnalyticsScreen> {
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
          "Analytics",
          style: GoogleFonts.poppins(
            color: AppColors.primaryButtonColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.only(top: 8),
        //     child: SvgPicture.asset(
        //       "assets/images/back_button_icon.svg",
        //     ),
        //   ),
        // ),
      ),
      body: FutureBuilder<ShopModel?>(
          future: _shopController.getLocalShopData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ShopModel shopModel = snapshot.data!;
              return SingleChildScrollView(
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              "Payment History",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.blackColor,
                              ),
                            ),
                            Text(
                              shopModel.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: AppColors.blackColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.secondryContainerColor,
                              ),
                              child: FutureBuilder(
                                  future: _shopController.getShopAnalytics(
                                    context: context,
                                    shop_id: shopModel.shop_id,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Map<String, dynamic> shopAnalytics =
                                          snapshot.data!;

                                      // debugPrint(shopAnalytics.toString());

                                      return Table(
                                        border: TableBorder.all(
                                          color: AppColors.greyColor,
                                        ),
                                        children: [
                                          TableRow(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Total Orders",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              top: 4,
                                                              bottom: 4),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryButtonColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Text(
                                                        shopAnalytics[
                                                                "numAllOrders"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Daily Orders",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              top: 4,
                                                              bottom: 4),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryButtonColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Text(
                                                        shopAnalytics[
                                                                "numOrdersPastDay"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Total Collection",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              top: 4,
                                                              bottom: 4),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryButtonColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Text(
                                                        "Rs ${shopAnalytics["totalAllOrdersAmount"]}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Daily Collection",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              top: 4,
                                                              bottom: 4),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryButtonColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Text(
                                                        "Rs ${shopAnalytics["totalOrdersPastDayAmount"]}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const CustomLoader();
                                    }
                                  }),
                            ),
                            const SizedBox(height: 24),
                            FutureBuilder<List<OrderModel>>(
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        OrderModel orderModel =
                                            pastOrders[index];
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 16),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return OrderDetailsScreen(
                                                        orderModel: orderModel);
                                                  },
                                                ),
                                              );
                                            },
                                            child: OrderHistoryCard(
                                                orderModel: orderModel),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  return const CustomLoader();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: size.height,
                width: size.width,
                child: const CustomLoader(),
              );
            }
          }),
    );
  }
}
