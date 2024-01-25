import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/order_controller.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/dashboard/shop_analytics/widgets/order_history_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class ShopAnalyticsScreen extends StatefulWidget {
  const ShopAnalyticsScreen({super.key});

  @override
  State<ShopAnalyticsScreen> createState() => _ShopAnalyticsScreenState();
}

class _ShopAnalyticsScreenState extends State<ShopAnalyticsScreen> {
  final ShopController _shopController = ShopController();
  final OrderController _orderController = OrderController();
  int _totalOrderCount = 180;
  int _dailyOrderCount = 15;
  double _totalSalesAmount = 150900;
  double _dailySalesAmount = 3090;

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
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.secondryContainerColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Total Orders",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryButtonColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            _totalOrderCount.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Divider(
                                          thickness: 1,
                                          color: AppColors.greyColor,
                                        ),
                                        Text(
                                          "Daily Orders",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryButtonColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            _dailyOrderCount.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Total Collection",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryButtonColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            "Rs $_totalSalesAmount",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Divider(
                                          thickness: 1,
                                          color: AppColors.greyColor,
                                        ),
                                        Text(
                                          "Daily Collection",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryButtonColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            "Rs $_dailySalesAmount",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            FutureBuilder(
                              future: _orderController.getPastOrders(
                                  shopModel: shopModel),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  List<OrderModel> orders = snapshot.data!;
                                  if (orders.isEmpty) {
                                    return SizedBox(
                                        height: size.height,
                                        width: size.width,
                                        child: const Text("No Orders"));
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: orders.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            OrderHistoryCard(
                                                orderModel: orders[index]),
                                            const SizedBox(height: 12),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  return SizedBox(
                                    height: size.height,
                                    width: size.width,
                                    child: const CustomLoader(),
                                  );
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
