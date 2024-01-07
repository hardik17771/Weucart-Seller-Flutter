import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/seller_model.dart';
import 'package:weu_cart_seller/views/auth/shop/shop_location_screen.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';

class AddShopScreen extends StatefulWidget {
  final SellerModel sellerModel;
  const AddShopScreen({
    super.key,
    required this.sellerModel,
  });

  @override
  State<AddShopScreen> createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _gstCodeController = TextEditingController();
  TimeOfDay shopOpeningTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay shopClosingTime = const TimeOfDay(hour: 9, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryAppBarColor,
        title: Text(
          "Shops Details",
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
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _shopNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid shop name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.store,
                      color: AppColors.primaryButtonColor,
                    ),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelText: 'Shop Name *',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefix: const Text("+91 "),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppColors.primaryButtonColor,
                    ),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelText: 'Phone Number *',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailIdController,
                  validator: (value) =>
                      value!.isValidEmail() ? null : "Enter a valid Email-Id",
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primaryButtonColor,
                    ),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelText: 'Email Id *',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _gstCodeController,
                  validator: (value) {
                    if (value == null || value.length != 15) {
                      return 'Enter a valid GST number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppColors.primaryButtonColor,
                    ),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelText: 'GST Number *',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter shop opening and closing hours',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: shopOpeningTime,
                        );
                        if (pickedTime != null) {
                          setState(() {
                            shopOpeningTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: AppColors.greyColor,
                          ),
                        ),
                        child: Text(
                          'Opens at ${shopOpeningTime.format(context)} *',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: shopClosingTime,
                        );
                        if (pickedTime != null) {
                          setState(() {
                            shopClosingTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: AppColors.greyColor,
                          ),
                        ),
                        child: Text(
                          'Closes at ${shopClosingTime.format(context)} *',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Choose your product categories',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          text: "Next",
          bgColor: AppColors.primaryButtonColor,
          textColor: AppColors.whiteColor,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              final DateTime now = DateTime.now();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ShopLocationScreen(
                      sellerModel: widget.sellerModel,
                      shopName: _shopNameController.text.trim(),
                      emailId: _emailIdController.text.trim(),
                      phoneNumber: _phoneNumberController.text.trim(),
                      gstCode: _gstCodeController.text.trim(),
                      categories: const [],
                      shopOpeningTime: DateTime(
                        now.year,
                        now.month,
                        now.day,
                        shopOpeningTime.hour,
                        shopOpeningTime.minute,
                      ),
                      shopClosingTime: DateTime(
                        now.year,
                        now.month,
                        now.day,
                        shopClosingTime.hour,
                        shopClosingTime.minute,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
