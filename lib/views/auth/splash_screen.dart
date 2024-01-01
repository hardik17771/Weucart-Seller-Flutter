import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/views/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const DashboardScreen(pageIndex: 0);
          },
        ),
        (route) => false,
      );

      /// -------------------------- State Persistence ---------------------------->

      // bool userExists = await _userController.checkLocalUserDataExistence();
      // if (userExists == true) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return DashboardScreen(pageIndex: 0);
      //       },
      //     ),
      //     (route) => false,
      //   );
      // } else {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return LoginPhoneOTPScreen();
      //       },
      //     ),
      //     (route) => false,
      //   );
      // }
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
