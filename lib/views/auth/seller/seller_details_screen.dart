import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/seller_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/seller_model.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class SellerDetailsScreen extends StatefulWidget {
  final User user;
  const SellerDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  State<SellerDetailsScreen> createState() => _SellerDetailsScreenState();
}

class _SellerDetailsScreenState extends State<SellerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isLoading;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final SellerController _sellerController = SellerController();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

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
                              "Enter your detail",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryButtonColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8),
                            child: TextFormField(
                              controller: _firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your first name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 20,
                                  color: AppColors.primaryButtonColor,
                                ),
                                errorStyle: GoogleFonts.poppins(fontSize: 10),
                                labelText: 'First Name *',
                                labelStyle: GoogleFonts.poppins(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                contentPadding: const EdgeInsets.all(8.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8),
                            child: TextFormField(
                              controller: _lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your last name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'last Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 20,
                                  color: AppColors.primaryButtonColor,
                                ),
                                errorStyle: GoogleFonts.poppins(fontSize: 10),
                                labelText: 'last Name *',
                                labelStyle: GoogleFonts.poppins(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                contentPadding: const EdgeInsets.all(8.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8),
                            child: TextFormField(
                              controller: _emailIdController,
                              validator: (value) => value!.isValidEmail()
                                  ? null
                                  : "Enter a valid Email-Id",
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email Id',
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 20,
                                  color: AppColors.primaryButtonColor,
                                ),
                                labelText: 'Email Id *',
                                labelStyle: GoogleFonts.poppins(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                contentPadding: const EdgeInsets.all(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          (_isLoading == true)
                              ? const CustomLoader()
                              : SizedBox(
                                  width: size.width / 2,
                                  child: CustomButton(
                                    text: "Next",
                                    bgColor: AppColors.primaryButtonColor,
                                    textColor: AppColors.whiteColor,
                                    onPress: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        SellerModel sellerModel = SellerModel(
                                          seller_id: 0,
                                          sellerUid: widget.user.uid,
                                          name:
                                              "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}",
                                          email: _emailIdController.text.trim(),
                                          phone: widget.user.phoneNumber!,
                                          deviceToken: "1",
                                          profileImage: "",
                                          shops_owned: [],
                                        );

                                        await _sellerController
                                            .createSellerData(
                                          sellerModel: sellerModel,
                                          context: context,
                                        );

                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
