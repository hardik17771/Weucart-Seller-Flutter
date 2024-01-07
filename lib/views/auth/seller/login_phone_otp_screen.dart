import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/views/auth/seller/verifly_phone_otp_screen.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/loginbackground.png"),
              ),
            ),
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 20, top: 25),
                          child: Text(
                            "Log In",
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryButtonColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextFormField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              prefix: const Text("+91 "),
                              prefixIcon: Icon(
                                Icons.phone,
                                size: 20,
                                color: AppColors.primaryButtonColor,
                              ),
                              labelText: 'Mobile Number *',
                              labelStyle: GoogleFonts.poppins(
                                color: AppColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              contentPadding: const EdgeInsets.all(8),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.length != 10) {
                                return 'Enter a valid mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: size.width / 2,
                          child: CustomButton(
                            text: "Get OTP",
                            bgColor: AppColors.primaryButtonColor,
                            textColor: AppColors.whiteColor,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return VeriflyPhoneOTPScreen(
                                        phoneNumber:
                                            _phoneNumberController.text.trim(),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
