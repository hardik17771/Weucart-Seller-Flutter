import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/order_model.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderModel orderModel;
  const OrderHistoryCard({
    super.key,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondryContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${DateFormat('dd-MM-yyyy').format(orderModel.order_placing_time)} | ${orderModel.customer_name}",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "paymentMode | COD",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryButtonColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Rs ${orderModel.total_amount}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
