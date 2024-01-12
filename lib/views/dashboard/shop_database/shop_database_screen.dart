import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/dashboard/add_product/add_product_screen.dart';
import 'package:weu_cart_seller/views/dashboard/shop_database/widgets/shop_product_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class ShopDatabaseScreen extends StatefulWidget {
  const ShopDatabaseScreen({super.key});

  @override
  State<ShopDatabaseScreen> createState() => _ShopDatabaseScreenState();
}

class _ShopDatabaseScreenState extends State<ShopDatabaseScreen> {
  final ShopController _shopController = ShopController();
  final ProductController _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryAppBarColor,
        title: Text(
          "Shop Database",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.primaryButtonColor,
          ),
        ),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.only(top: 8),
        //     child: SvgPicture.asset(
        //       "assets/images/back_button_icon.svg",
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: _shopController.getLocalShopData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ShopModel shopModel = snapshot.data!;
                return FutureBuilder(
                  future:
                      _productController.getShopProducts(shopModel: shopModel),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProductModel> products = snapshot.data!;
                      if (products.isEmpty) {
                        return SizedBox(
                          height: size.height,
                          width: size.width,
                          child: SizedBox(
                            width: size.width / 2,
                            child: Center(
                              child: CustomButton(
                                text: "Add Products in shop",
                                bgColor: AppColors.primaryButtonColor,
                                textColor: AppColors.whiteColor,
                                onPress: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const AddProductScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ShopProductCard(productModel: products[index]),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      return SizedBox(
                        height: size.height,
                        width: size.width,
                        child: const CustomLoader(),
                      );
                    }
                  },
                );
              } else {
                return SizedBox(
                  height: size.height,
                  width: size.width,
                  child: const CustomLoader(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}