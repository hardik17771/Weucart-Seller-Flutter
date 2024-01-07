import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/seller_controller.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/seller_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/auth/shop/add_shop_screen.dart';
import 'package:weu_cart_seller/views/auth/shop/widgets/seller_shop_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class SellerShopDashboardScreen extends StatefulWidget {
  const SellerShopDashboardScreen({super.key});

  @override
  State<SellerShopDashboardScreen> createState() =>
      _SellerShopDashboardScreenState();
}

class _SellerShopDashboardScreenState extends State<SellerShopDashboardScreen> {
  final SellerController _sellerController = SellerController();
  final ShopController _shopController = ShopController();

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
          "Shops Dashboard",
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
          width: size.width,
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: _sellerController.getLocalSellerData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                SellerModel sellerModel = snapshot.data!;
                List<String> shopIds = sellerModel.shops;

                return Column(
                  children: [
                    if (shopIds.isNotEmpty)
                      Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: shopIds.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FutureBuilder(
                                future: _shopController.readShopData(
                                    shopId: shopIds[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    ShopModel shopModel = snapshot.data;
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: SellerShopCard(
                                        shopModel: shopModel,
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                      width: size.width,
                                      child: const CustomLoader(),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    CustomButton(
                      text: "Add Shop",
                      bgColor: AppColors.primaryButtonColor,
                      textColor: AppColors.whiteColor,
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AddShopScreen(sellerModel: sellerModel);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const CustomLoader();
              }
            },
          ),
        ),
      ),
    );
  }
}
