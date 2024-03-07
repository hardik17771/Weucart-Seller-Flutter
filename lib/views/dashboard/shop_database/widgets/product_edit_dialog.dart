import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/shop_database_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/product/product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/dashboard/dashboard_screen.dart';

void showEditProductDialog({
  required BuildContext context,
  required ProductModel productModel,
  required ShopModel shopModel,
  required int productQuantity,
  required int productUnitPrice,
}) {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _quantityController =
      TextEditingController(text: productQuantity.toString());
  TextEditingController _priceController =
      TextEditingController(text: productUnitPrice.toString());
  final ShopDatabaseController _shopDatabaseController =
      ShopDatabaseController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (BuildContext context, setState) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            productModel.name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Quantity:",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: _quantityController,
                            validator: (value) {
                              if (value == null || int.parse(value) < 0) {
                                return 'Enter a valid quantity';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.primaryContainerColor,
                              errorStyle: GoogleFonts.poppins(fontSize: 10),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              contentPadding: const EdgeInsets.only(left: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Price:",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: _priceController,
                            validator: (value) {
                              if (value == null || int.parse(value) < 0) {
                                return 'Enter a valid price';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.primaryContainerColor,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              errorStyle: GoogleFonts.poppins(fontSize: 10),
                              contentPadding: const EdgeInsets.only(left: 12.0),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryContainerColor,
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await _shopDatabaseController.updateShopProductData(
                          context: context,
                          shopModel: shopModel,
                          productModel: productModel,
                          updatedPrice: int.parse(_priceController.text.trim()),
                          updatedQuantity:
                              int.parse(_quantityController.text.trim()),
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) {
                              return const DashboardScreen(pageIndex: 4);
                            },
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryButtonColor.withOpacity(0.8),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
    },
  );
}
