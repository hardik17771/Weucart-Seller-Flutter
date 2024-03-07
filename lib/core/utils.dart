import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weu_cart_seller/core/colors.dart';

void showCustomDialog(
    {required BuildContext context,
    required String title,
    required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              "Continue",
              style: GoogleFonts.poppins(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryButtonColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.primaryButtonColor,
      content: Text(text),
    ),
  );
}

void showToast({required String text}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3,
    backgroundColor: AppColors.greyColor,
    textColor: AppColors.whiteColor,
    fontSize: 15.0,
  );
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

Future<File?> pickImage() async {
  File? pickerImage;
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickerImage = File(image.path);
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
  return pickerImage;
}
