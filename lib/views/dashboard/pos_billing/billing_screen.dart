import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_document/open_document.dart';
import 'package:weu_cart_seller/controllers/dashboard/pdf_invoice_controller.dart';
import 'package:weu_cart_seller/controllers/dashboard/shop_database_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/product/pos_product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/dashboard/pos_billing/pos_order_placed_screen.dart';
import 'package:weu_cart_seller/views/dashboard/pos_billing/widgets/billing_product_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';

class OfflineOrderBillingPage extends StatefulWidget {
  final ShopModel shopModel;
  final List<POSProductModel> products;
  const OfflineOrderBillingPage({
    super.key,
    required this.shopModel,
    required this.products,
  });

  @override
  State<OfflineOrderBillingPage> createState() =>
      _OfflineOrderBillingPageState();
}

class _OfflineOrderBillingPageState extends State<OfflineOrderBillingPage> {
  final _formKey = GlobalKey<FormState>();
  final PdfInvoiceController pdfInvoiceController = PdfInvoiceController();
  final ShopDatabaseController _shopDatabaseController =
      ShopDatabaseController();

  late bool _isLoading;
  double totalAmount = 0;
  int totalQuantity = 0;
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneNumberController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    for (int i = 0; i < widget.products.length; i++) {
      totalQuantity += widget.products[i].quantity;
      totalAmount +=
          widget.products[i].unit_price * widget.products[i].quantity;
    }
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
          "Invoice Generator",
          style: GoogleFonts.poppins(
            color: AppColors.primaryButtonColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
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
      body: Container(
        padding: const EdgeInsets.all(16),
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Product Name",
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            vertical: BorderSide(
                              width: 1,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                        child: Text(
                          "Quantity",
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Unit price",
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Total price",
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return BillingProductCard(
                      productModel: widget.products[index]);
                },
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Total",
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            vertical: BorderSide(
                              width: 1,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                        child: Text(
                          totalQuantity.toString(),
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Rs. ${totalAmount.toString()}",
                          style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: AppColors.primaryContainerColor,
        width: size.width,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _customerNameController,
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Enter a valid name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: AppColors.whiteColor,
                  errorStyle: GoogleFonts.poppins(fontSize: 10),
                  labelText: 'Customer Name',
                  labelStyle: GoogleFonts.poppins(
                    color: AppColors.blackColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _customerPhoneNumberController,
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: AppColors.whiteColor,
                  errorStyle: GoogleFonts.poppins(fontSize: 10),
                  labelText: 'Customer Phone No.',
                  labelStyle: GoogleFonts.poppins(
                    color: AppColors.blackColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(
                text: "Place order",
                bgColor: AppColors.primaryButtonColor,
                textColor: AppColors.whiteColor,
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });

                    bool isOrderPlaced = true;

                    //  ------------------ Updating Shop Inventry -------------------------------->
                    for (var currentProduct in widget.products) {
                      bool isQuantityUpdated =
                          await _shopDatabaseController.updateShopProductData(
                        context: context,
                        shopModel: widget.shopModel,
                        productId: currentProduct.product_id,
                        updatedQuantity: currentProduct.quantity,
                        updatedPrice: currentProduct.unit_price,
                      );

                      if (isQuantityUpdated == false) {
                        isOrderPlaced = false;
                        break;
                      }
                    }

                    if (isOrderPlaced) {
                      // ------------------- Generate pdf & save pdf ------------------------------->
                      String invoiceId = DateTime.now().toIso8601String();
                      final data = await pdfInvoiceController.createInvoice(
                        invoiceId: invoiceId,
                        shopModel: widget.shopModel,
                        customerName: _customerNameController.text.trim(),
                        customerPhone:
                            _customerPhoneNumberController.text.trim(),
                        products: widget.products,
                      );
                      String filePath = await pdfInvoiceController.savePdfFile(
                        fileName: invoiceId,
                        byteList: data,
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return POSOrderPlacedScreen(
                              filePath: filePath,
                              customerPhone:
                                  _customerPhoneNumberController.text.trim(),
                            );
                          },
                        ),
                        (route) => false,
                      );
                    } else {
                      debugPrint("POS Order not placed");
                    }

                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
