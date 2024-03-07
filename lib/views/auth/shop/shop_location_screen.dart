import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/fcm_notification_controller.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/seller_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class ShopLocationScreen extends StatefulWidget {
  final SellerModel sellerModel;
  final String shopName;
  final String emailId;
  final String phoneNumber;
  final String gstCode;
  final List<String> categories;
  final DateTime shopOpeningTime;
  final DateTime shopClosingTime;
  const ShopLocationScreen({
    super.key,
    required this.sellerModel,
    required this.shopName,
    required this.emailId,
    required this.phoneNumber,
    required this.gstCode,
    required this.categories,
    required this.shopOpeningTime,
    required this.shopClosingTime,
  });

  @override
  State<ShopLocationScreen> createState() => _ShopLocationScreenState();
}

class _ShopLocationScreenState extends State<ShopLocationScreen> {
  final ShopController _shopController = ShopController();

  Position? _currentPosition;
  late bool _isLocationLoading;
  late bool _isDataLoading;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentAddressController =
      TextEditingController();
  final TextEditingController _currentCityController = TextEditingController();
  final TextEditingController _currentPincodeController =
      TextEditingController();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Location Error",
        message: "Location services are disabled. Please enable the services",
      );
      setState(() {
        _isLocationLoading = false;
      });
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Location Error",
          message: "Location permissions are denied",
        );
        setState(() {
          _isLocationLoading = false;
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Location Error",
        message:
            "Location permissions are permanently denied, we cannot request permissions.",
      );
      setState(() {
        _isLocationLoading = false;
      });
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition!);
      });
    }).catchError((e) {
      debugPrint(e);
      setState(() {
        _isLocationLoading = false;
      });
      showCustomDialog(
        context: context,
        title: "Location Error",
        message: e.toString(),
      );
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    ).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddressController.text =
            '${place.street}, ${place.subLocality}';
        _currentCityController.text = place.locality!;
        _currentPincodeController.text = place.postalCode!;
      });
    }).catchError((e) {
      setState(() {
        _isLocationLoading = false;
      });
      showCustomDialog(
        context: context,
        title: "Location Error",
        message: e.toString(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _isLocationLoading = false;
    _isDataLoading = false;
  }

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
          "Shop Location",
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
            width: size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   'Enter your Location',
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.poppins(
                //     fontWeight: FontWeight.w500,
                //     color: AppColors.blackColor,
                //     fontSize: 20,
                //   ),
                // ),
                // const SizedBox(height: 24),
                (_isLocationLoading == true)
                    ? SizedBox(
                        width: size.width,
                        height: 45,
                        child: const CustomLoader(),
                      )
                    : CustomButton(
                        text: "Get Live Location",
                        bgColor: AppColors.primaryButtonColor,
                        textColor: AppColors.whiteColor,
                        onPress: () async {
                          setState(() {
                            _isLocationLoading = true;
                          });

                          await _getCurrentPosition();

                          setState(() {
                            _isLocationLoading = false;
                          });
                        },
                      ),
                if (_currentPosition != null)
                  SizedBox(
                    width: size.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _currentAddressController,
                          validator: (value) {
                            if (value == null) {
                              return 'Enter a valid address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.whiteColor,
                            errorStyle: GoogleFonts.poppins(fontSize: 10),
                            labelText: 'Address',
                            labelStyle: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            contentPadding: const EdgeInsets.all(16.0),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _currentCityController,
                          validator: (value) {
                            if (value == null) {
                              return 'Enter a valid city';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.whiteColor,
                            errorStyle: GoogleFonts.poppins(fontSize: 10),
                            labelText: 'City',
                            labelStyle: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            contentPadding: const EdgeInsets.all(16.0),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _currentPincodeController,
                          validator: (value) {
                            if (value == null || value.length != 6) {
                              return 'Enter a valid pincode';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.whiteColor,
                            errorStyle: GoogleFonts.poppins(fontSize: 10),
                            labelText: 'Pincode',
                            labelStyle: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            contentPadding: const EdgeInsets.all(16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(16),
        child: (_isDataLoading == true)
            ? SizedBox(
                width: size.width,
                height: 45,
                child: const CustomLoader(),
              )
            : CustomButton(
                text: "Add Shop",
                bgColor: AppColors.primaryButtonColor,
                textColor: AppColors.whiteColor,
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_currentPosition != null) {
                      setState(() {
                        _isDataLoading = true;
                      });

                      String deviceToken =
                          await FCMNotificationController().getDeviceToken();

                      ShopModel shopModel = ShopModel(
                        seller_id: widget.sellerModel.seller_id,
                        sellerUid: widget.sellerModel.sellerUid,
                        manager_phone: widget.phoneNumber,
                        shop_id: 0,
                        name: widget.shopName,
                        email: widget.emailId,
                        shop_images: [],
                        latitude: _currentPosition!.latitude.toString(),
                        longitude: _currentPosition!.longitude.toString(),
                        address: _currentAddressController.text.trim(),
                        city: _currentCityController.text.trim(),
                        state: "State",
                        country: "India",
                        pincode: _currentPincodeController.text.trim(),
                        products: [],
                        gst_code: widget.gstCode,
                        serving_radius: 10,
                        status: "Offline",
                        rating: 0,
                        deviceToken: deviceToken,
                        reviews: [],
                        opening_time: widget.shopOpeningTime,
                        closing_time: widget.shopClosingTime,
                        categories_list: [],
                        is_delivery_boy: false,
                        logo: "",
                        facebook: "",
                        google: "",
                        twitter: "",
                        youtube: "",
                        instagram: "",
                        sold_products: [],
                        no_of_products: 0,
                        is_gst_code: true,
                      );

                      // ignore: use_build_context_synchronously
                      await _shopController.createShopData(
                        context: context,
                        shopModel: shopModel,
                      );

                      setState(() {
                        _isDataLoading = false;
                      });
                    } else {
                      showSnackBar(
                        context: context,
                        text: "Get your live Location",
                      );
                    }
                  }
                },
              ),
      ),
    );
  }
}
