import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/order_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/views/dashboard/widgets/live_order_card.dart';
import 'package:weu_cart_seller/views/dashboard/widgets/past_order_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class PastOrdersScreen extends StatefulWidget {
  const PastOrdersScreen({super.key});

  @override
  State<PastOrdersScreen> createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  final OrderController _orderController = OrderController();

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
          "Past Orders",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.primaryButtonColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset(
              "assets/images/back_button_icon.svg",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: _orderController.getLiveOrders(shopModel: dummyShopModel),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<OrderModel> ordersList = snapshot.data!;
                if (ordersList.isEmpty) {
                  return SizedBox(
                    width: size.width,
                    height: size.height,
                    child: const Center(
                      child: Text("No Orders"),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: ordersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PastOrderCard(orderModel: ordersList[index]),
                          const SizedBox(height: 8),
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
            }),
          ),
        ),
      ),
    );
  }
}
