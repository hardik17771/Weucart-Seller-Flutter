import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/views/dashboard/widgets/order_product_card.dart';

class LiveOrderCard extends StatefulWidget {
  final OrderModel orderModel;
  const LiveOrderCard({
    super.key,
    required this.orderModel,
  });

  @override
  State<LiveOrderCard> createState() => _LiveOrderCardState();
}

class _LiveOrderCardState extends State<LiveOrderCard> {
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
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          AppConstants.defaultProfileImage,
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
                            widget.orderModel.customerName,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.orderModel.customerAddressModel.address,
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
                        "Rs ${widget.orderModel.orderAmount}",
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
                    Container(
                      color: AppColors.tertiaryContainerColor,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: widget.orderModel.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OrderProductCard(
                            productModel: widget.orderModel.products[index],
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.secondryButtonColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
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
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
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
                        const SizedBox(width: 8),
                      ],
                    ),
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
