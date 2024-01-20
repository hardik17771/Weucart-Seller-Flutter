import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/views/dashboard/pos_billing/billing_screen.dart';
import 'package:weu_cart_seller/views/dashboard/pos_billing/widgets/qr_scan_product_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';

class QrScanningScreen extends StatefulWidget {
  const QrScanningScreen({super.key});

  @override
  State<QrScanningScreen> createState() => _QrScanningScreenState();
}

class _QrScanningScreenState extends State<QrScanningScreen> {
  final ProductController _productController = ProductController();
  late List<ProductModel> products;

  @override
  void initState() {
    super.initState();
    products = [
      dummmyProductModel,
      dummmyProductModel,
      dummmyProductModel,
    ];
  }

  Future<String?> _startBarCodeScan() async {
    String? result;
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context: context,
        text: e.toString(),
      );
    }

    return result;
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
          "Scan Product QR",
          style: GoogleFonts.poppins(
            color: AppColors.primaryButtonColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.only(top: 8),
        //     child: SvgPicture.asset(
        //       "assets/images/back_button_icon.svg",
        //     ),
        //   ),
        // ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  String? result = await _startBarCodeScan();
                  if (result != null && result != "-1") {
                    // Search this productISBN into shop db
                    // 1 -> found -> add product to list

                    ProductModel? productModel =
                        // ignore: use_build_context_synchronously
                        await _productController.getShopProductByISBN(
                      context: context,
                      productISBN: result,
                    );

                    if (productModel != null) {
                      setState(() {
                        products.add(productModel);
                      });
                    }

                    // 2 -> not found -> Navigater to add product screen
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryButtonColor.withOpacity(0.8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        size: 48,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Scan Barcode",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: size.width,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: QrScanProductCard(productModel: products[index]),
                    );
                  }),
              if (products.isNotEmpty)
                CustomButton(
                  text: "Generate Bill",
                  bgColor: AppColors.primaryButtonColor,
                  textColor: AppColors.whiteColor,
                  onPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return OfflineOrderBillingPage(
                            products: products,
                          );
                        },
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
