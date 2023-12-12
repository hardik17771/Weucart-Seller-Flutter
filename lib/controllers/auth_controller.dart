import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/views/auth/splash_screen.dart';

class AuthController {
  Future<void> logOut({
    required BuildContext context,
  }) async {
    try {
      // await _userController.removeLocalUserData();
      FirebaseAuth.instance.signOut();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(
        context: context,
        text: e.toString(),
      );
    }
  }
}
