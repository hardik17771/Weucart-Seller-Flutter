import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/order_controller.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/product/product_model.dart';
import 'package:weu_cart_seller/views/dashboard/orders/widgets/order_product_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class LiveOrderCard extends StatefulWidget {
  final Function() notifyParent;
  final OrderModel orderModel;
  const LiveOrderCard({
    super.key,
    required this.notifyParent,
    required this.orderModel,
  });

  @override
  State<LiveOrderCard> createState() => _LiveOrderCardState();
}

class _LiveOrderCardState extends State<LiveOrderCard> {
  final ProductController _productController = ProductController();
  final OrderController _orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.primaryContainerColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.15),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.width,
            color: AppColors.primaryContainerColor.withOpacity(0.80),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(0),
              trailing: const Icon(
                Icons.arrow_drop_down,
                size: 26,
              ),
              initiallyExpanded: false,
              maintainState: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.person,
                          color: AppColors.greyColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "From",
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryButtonColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.orderModel.customer_name,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.orderModel.customer_current_address.address,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryButtonColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Rs ${widget.orderModel.total_amount}",
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 4),

                    // ----------------------- Grocery Products ----------------------------------- >
                    if (widget.orderModel.grocery_cart_products.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            "Groceries",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.primaryButtonColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ListView(
                            shrinkWrap: true,
                            children: widget
                                .orderModel.grocery_cart_products.keys
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
                                          future:
                                              _productController.getProductById(
                                            context: context,
                                            productId: currentShopProduct[
                                                "product_id"],
                                          ),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              ProductModel currentProductModel =
                                                  snapshot.data!;

                                              return OrderProductCard(
                                                productModel:
                                                    currentProductModel,
                                                shopPrice: currentShopProduct[
                                                    "shop_price"],
                                                quantity: currentShopProduct[
                                                    "quantity"],
                                              );
                                            } else {
                                              return const CustomLoader();
                                            }
                                          }),
                                      const SizedBox(height: 12),
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
                              fontSize: 12,
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
                                          future:
                                              _productController.getProductById(
                                            context: context,
                                            productId: currentShopProduct[
                                                "product_id"],
                                          ),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              ProductModel currentProductModel =
                                                  snapshot.data!;

                                              return OrderProductCard(
                                                productModel:
                                                    currentProductModel,
                                                shopPrice: currentShopProduct[
                                                    "shopProductsAmount"],
                                                quantity: currentShopProduct[
                                                    "quantity"],
                                              );
                                            } else {
                                              return const CustomLoader();
                                            }
                                          }),
                                      const SizedBox(height: 12),
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                    (widget.orderModel.is_accepted == "pending")
                        ? Row(
                            children: [
                              const SizedBox(width: 8),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    await _orderController
                                        .updateOrderAcceptanceStatus(
                                      orderModel: widget.orderModel,
                                      isAccepted: "declined",
                                    );

                                    widget.notifyParent();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.secondryButtonColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    child: Center(
                                      child: Text(
                                        "Reject",
                                        style: GoogleFonts.poppins(
                                          color: AppColors.whiteColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    await _orderController
                                        .updateOrderAcceptanceStatus(
                                      orderModel: widget.orderModel,
                                      isAccepted: "accepted",
                                    );

                                    await _orderController
                                        .updateOrderCurrentStatus(
                                      orderModel: widget.orderModel,
                                      status: "acceptedByShop",
                                    );

                                    widget.notifyParent();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.greenColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    child: Center(
                                      child: Text(
                                        "Accept",
                                        style: GoogleFonts.poppins(
                                          color: AppColors.whiteColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          )
                        : (widget.orderModel.is_accepted == "decilned")
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColors.secondryButtonColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 4),
                                child: Center(
                                  child: Text(
                                    widget.orderModel.is_accepted,
                                    style: GoogleFonts.poppins(
                                      color: AppColors.whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  if (widget.orderModel.status == "delivered") {
                                    debugPrint("Order Delivered Already");
                                  } else {
                                    await _orderController
                                        .updateOrderCurrentStatus(
                                      orderModel: widget.orderModel,
                                      status: (widget.orderModel.status ==
                                              "acceptedByShop")
                                          ? "readyToPickup"
                                          : (widget.orderModel.status ==
                                                  "readyToPickup")
                                              ? "delivered"
                                              : "",
                                    );
                                  }
                                  widget.notifyParent();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: (widget.orderModel.status ==
                                            "delivered")
                                        ? AppColors.primaryButtonColor
                                        : AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.only(top: 4, bottom: 4),
                                  child: Center(
                                    child: Text(
                                      (widget.orderModel.status ==
                                              "acceptedByShop")
                                          ? "readyToPickup"
                                          : (widget.orderModel.status ==
                                                  "readyToPickup")
                                              ? "delivered"
                                              : widget.orderModel.status,
                                      style: GoogleFonts.poppins(
                                        color: AppColors.whiteColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    const SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
