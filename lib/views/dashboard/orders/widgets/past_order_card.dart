import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/order_model.dart';

class PastOrderCard extends StatefulWidget {
  final OrderModel orderModel;
  const PastOrderCard({super.key, required this.orderModel});

  @override
  State<PastOrderCard> createState() => _PastOrderCardState();
}

class _PastOrderCardState extends State<PastOrderCard> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 10,
            child: Row(
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
                Flexible(
                  child: Column(
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
                          fontSize: 14,
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
                      Text(
                        widget.orderModel.customer_current_address.city,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: (widget.orderModel.status == "delivered")
                        ? AppColors.greenColor
                        : AppColors.redColor,
                  ),
                  child: Text(
                    widget.orderModel.status,
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
