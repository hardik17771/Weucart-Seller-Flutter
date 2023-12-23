import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/constants.dart';
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
              const SizedBox(width: 24),
              Container(
                padding: const EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: (widget.orderModel.orderStatus == "Delivered")
                      ? AppColors.greenColor
                      : AppColors.redColor,
                ),
                child: Text(
                  widget.orderModel.orderStatus,
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          Column(
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
    );
  }
}
