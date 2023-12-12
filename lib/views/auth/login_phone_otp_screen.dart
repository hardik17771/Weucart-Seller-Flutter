import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/views/auth/verifly_phone_otp_screen.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';

class LoginPhoneOTPScreen extends StatefulWidget {
  const LoginPhoneOTPScreen({super.key});

  @override
  State<LoginPhoneOTPScreen> createState() => _LoginPhoneOTPScreenState();
}

class _LoginPhoneOTPScreenState extends State<LoginPhoneOTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryAppBarColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: screenWidth,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your mobile number to get OTP',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return 'Enter a valid mobile number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefix: const Text("+91 "),
                    prefixIcon: const Icon(Icons.phone),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelText: 'Mobile Number *',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      // borderSide: BorderSide(
                      // color: Colors.black,
                      // width: 10,
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(height: 36),
                CustomButton(
                  text: "Get OTP",
                  bgColor: AppColors.primaryButtonColor,
                  textColor: AppColors.whiteColor,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return VeriflyPhoneOTPScreen(
                              phoneNumber: _phoneNumberController.text.trim(),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
