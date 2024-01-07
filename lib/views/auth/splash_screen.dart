import 'package:flutter/material.dart';
import 'package:weu_cart_seller/controllers/seller_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/views/auth/seller/login_phone_otp_screen.dart';
import 'package:weu_cart_seller/views/auth/shop/seller_shop_dashboard_screen.dart';
import 'package:weu_cart_seller/views/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SellerController _sellerController = SellerController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      /// -------------------------- State Persistence ---------------------------->

      bool sellerExists =
          await _sellerController.checkLocalSellerDataExistence();
      if (sellerExists == true) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const SellerShopDashboardScreen();
            },
          ),
          (route) => false,
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const LoginPhoneOTPScreen();
            },
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryButtonColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/splashbackground.png"),
          ),
        ),
        child: Center(
          child: Image.asset("assets/icons/icon.png"),
        ),
      ),
    );
  }
}
