import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/product/product_model.dart';

class OrderProductCard extends StatelessWidget {
  final ProductModel productModel;
  final int quantity;
  final int shopPrice;
  const OrderProductCard({
    super.key,
    required this.productModel,
    required this.quantity,
    required this.shopPrice,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      width: width,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.tertiaryContainerColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(productModel.thumbnail_img),
                        fit: BoxFit.fitHeight,
                      ),
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: width / 8,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          productModel.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 8,
                            color: AppColors.primaryButtonColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "4.4", // currently static
                            style: GoogleFonts.poppins(
                              fontSize: 8,
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
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
                decoration: BoxDecoration(
                  color: AppColors.primaryButtonColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.5),
                ),
                child: Text(
                  "$quantity N",
                  style: GoogleFonts.poppins(
                    fontSize: 7.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Rs. $shopPrice",
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryButtonColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
