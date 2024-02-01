import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/product_model.dart';

class BillingProductCard extends StatefulWidget {
  final ProductModel productModel;
  const BillingProductCard({
    super.key,
    required this.productModel,
  });

  @override
  State<BillingProductCard> createState() => _BillingProductCardState();
}

class _BillingProductCardState extends State<BillingProductCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.greyColor,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              widget.productModel.name,
              style: GoogleFonts.poppins(
                color: AppColors.blackColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    width: 1,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              child: Text(
                widget.productModel.total_quantity.toString(),
                style: GoogleFonts.poppins(
                  color: AppColors.blackColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              child: Text(
                textAlign: TextAlign.center,
                widget.productModel.unit_price.toString(),
                style: GoogleFonts.poppins(
                  color: AppColors.blackColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                textAlign: TextAlign.center,
                "${widget.productModel.unit_price * widget.productModel.total_quantity}",
                style: GoogleFonts.poppins(
                  color: AppColors.blackColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
