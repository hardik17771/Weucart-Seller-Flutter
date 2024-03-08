import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/product/product_model.dart';
import 'package:weu_cart_seller/views/dashboard/orders/widgets/order_product_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetailsScreen({
    required this.orderModel,
    super.key,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final ProductController _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryAppBarColor,
        title: Text(
          "Order Receipt",
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
      body: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------- Grocery Cart Products ------------------------------>
              if (widget.orderModel.grocery_cart_products.isNotEmpty)
                Column(
                  children: [
                    Text(
                      "Groceries",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.primaryButtonColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ListView(
                      shrinkWrap: true,
                      children: widget.orderModel.grocery_cart_products.keys
                          .map<Widget>((key) {
                        List<dynamic> shopProductsList =
                            widget.orderModel.grocery_cart_products[key];
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: shopProductsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> currentShopProduct =
                                shopProductsList[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FutureBuilder<ProductModel>(
                                    future: _productController.getProductById(
                                      context: context,
                                      productId:
                                          currentShopProduct["product_id"],
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        ProductModel currentProductModel =
                                            snapshot.data!;

                                        return OrderProductCard(
                                          productModel: currentProductModel,
                                          shopPrice:
                                              currentShopProduct["shop_price"],
                                          quantity:
                                              currentShopProduct["quantity"],
                                        );
                                      } else {
                                        return const CustomLoader();
                                      }
                                    }),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              // ----------------------- Other Cart Products ----------------------------------- >
              if (widget.orderModel.cart_products.isNotEmpty)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other Categories",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.primaryButtonColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ListView(
                      shrinkWrap: true,
                      children: widget.orderModel.cart_products.keys
                          .map<Widget>((key) {
                        List<dynamic> shopProductsList =
                            widget.orderModel.cart_products[key];
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: shopProductsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> currentShopProduct =
                                shopProductsList[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FutureBuilder<ProductModel>(
                                    future: _productController.getProductById(
                                      context: context,
                                      productId:
                                          currentShopProduct["product_id"],
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        ProductModel currentProductModel =
                                            snapshot.data!;

                                        return OrderProductCard(
                                          productModel: currentProductModel,
                                          shopPrice: currentShopProduct[
                                              "shopProductsAmount"],
                                          quantity:
                                              currentShopProduct["quantity"],
                                        );
                                      } else {
                                        return const CustomLoader();
                                      }
                                    }),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),

              const SizedBox(height: 24),

              // ----------------------- Billing Details ------------------------>
              Container(
                width: width,
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainerColor,
                ),
                child: Text(
                  "BILL SUMMARY",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: width,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              size: 24,
                              color: AppColors.blackColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Subtotal",
                              style: GoogleFonts.poppins(
                                color: AppColors.blackColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "₹ ${widget.orderModel.total_amount}",
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              size: 24,
                              color: AppColors.blackColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Delivery Fee",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "₹ 0(Free)",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Container(
                    //           margin: const EdgeInsets.only(left: 3),
                    //           width: 20,
                    //           height: 20,
                    //           child: AppAssets.convenienceFeeIcon,
                    //         ),
                    //         Text(
                    //           " Convenience Fee",
                    //           style: GoogleFonts.poppins(
                    //             fontSize: 10,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Text(
                    //       "(Free)",
                    //       style: GoogleFonts.poppins(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 8),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grand Total",
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "₹ ${widget.orderModel.total_amount}",
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
