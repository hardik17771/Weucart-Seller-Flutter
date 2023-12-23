import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/auth/shop_details_screen.dart';
import 'package:weu_cart_seller/views/dashboard/dashboard_screen.dart';

class VeriflyPhoneOTPScreen extends StatefulWidget {
  final String phoneNumber;
  const VeriflyPhoneOTPScreen({
    required this.phoneNumber,
    super.key,
  });

  @override
  State<VeriflyPhoneOTPScreen> createState() => _VeriflyPhoneOTPScreenState();
}

class _VeriflyPhoneOTPScreenState extends State<VeriflyPhoneOTPScreen> {
  bool? _isLoading;
  String? _verificationCode;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  final ShopController _shopController = ShopController();

  int _start = 0;
  int endTime = DateTime.now().millisecond + 1000 * 30;

  @override
  void initState() {
    startTimer();
    _verifyPhoneNumber();
    _isLoading = false;
    super.initState();
  }

  void onEnd() {
    debugPrint('onEnd');
  }

  _navigateToUserDetailsScreen(User currentUser) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ShopDetailsScreen(
          user: currentUser,
        ),
      ),
      (route) => false,
    );
  }

  _navigateToHomePage() {
    /// TO-DO
    // readUserData
    // saveLocalUserData

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(pageIndex: 0),
      ),
      (route) => false,
    );
  }

  _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            // -------------------- Check User Data Existence in db ------------------------------------>
            User? currentUser = value.user;
            if (currentUser != null) {
              ShopModel? shopModel = await _shopController.readShopData(
                shop_uid: currentUser.uid,
                context: context,
              );

              if (shopModel != null) {
                _navigateToHomePage();
              } else {
                _navigateToUserDetailsScreen(currentUser);
              }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
          showCustomDialog(
            context: context,
            title: "Authentication Error",
            message: e.message!,
          );
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 5));
  }

  void startTimer() {
    _start = 60;
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }

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
                  'Enter the OTP we just sent to +91-${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                (_isLoading == true)
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Pinput(
                              length: 6,
                              controller: _pinController,
                              pinAnimationType: PinAnimationType.fade,
                              defaultPinTheme: PinTheme(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: AppColors.primaryButtonColor,
                                  border: Border.all(
                                      color: AppColors.primaryButtonColor),
                                ),
                              ),
                              submittedPinTheme: PinTheme(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: AppColors.primaryButtonColor,
                                  border: Border.all(
                                      color: AppColors.primaryButtonColor),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryButtonColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              followingPinTheme: PinTheme(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ),
                              onCompleted: (pin) async {
                                setState(() {
                                  _isLoading = true;
                                });

                                try {
                                  await FirebaseAuth.instance
                                      .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                      verificationId: _verificationCode!,
                                      smsCode: pin,
                                    ),
                                  )
                                      .then(
                                    (value) async {
                                      // -------------------- Check User Data Existence in db ------------------------------------>
                                      User? currentUser = value.user;
                                      if (currentUser != null) {
                                        ShopModel? shopModel =
                                            await _shopController.readShopData(
                                          shop_uid: currentUser.uid,
                                          context: context,
                                        );

                                        if (shopModel != null) {
                                          _navigateToHomePage();
                                        } else {
                                          _navigateToUserDetailsScreen(
                                              currentUser);
                                        }
                                      }
                                    },
                                  );
                                } on FirebaseException catch (e) {
                                  // ignore: use_build_context_synchronously
                                  showCustomDialog(
                                    context: context,
                                    title: "Authentication Error",
                                    message: e.message!,
                                  );
                                }

                                setState(() {
                                  _isLoading = false;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: Text(
                              "00.$_start",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              if (_start == 0) {
                                setState(() {
                                  _isLoading = true;
                                });

                                startTimer();
                                _verifyPhoneNumber();

                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: Text(
                              "Didn't recieve OTP?\n Resend",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
