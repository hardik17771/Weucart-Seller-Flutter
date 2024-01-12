import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

class SellerShopCard extends StatelessWidget {
  final ShopModel shopModel;
  const SellerShopCard({
    required this.shopModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.primaryContainerColor,
        borderRadius: BorderRadius.circular(15),
        // border: Border.all(
        // width: 0.2,
        // color: AppColors.blackColor,
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.blackColor.withOpacity(0.5),
        //     offset: const Offset(0, 2),
        //     blurRadius: 4,
        //     spreadRadius: 0,
        //   ),
        // ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width / 3.5,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryButtonColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                topRight: Radius.elliptical(12, 52.0),
                bottomRight: Radius.elliptical(12, 52.0),
              ),
            ),
            child: Image.network(shopModel.image),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    shopModel.shopName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${shopModel.addressModel.address}, ${shopModel.addressModel.city}",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 7,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 12,
                      color: AppColors.primaryButtonColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${shopModel.rating} Ratings",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 7,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.drive_file_rename_outline_sharp,
                      size: 9,
                      color: AppColors.primaryButtonColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "GST No. ${shopModel.gstCode}",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 7,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
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
