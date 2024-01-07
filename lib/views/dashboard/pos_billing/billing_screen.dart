import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_document/open_document.dart';
import 'package:weu_cart_seller/controllers/dashboard/pdf_invoice_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/views/dashboard/pos_billing/widgets/billing_product_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';

class OfflineOrderBillingPage extends StatefulWidget {
  final List<ProductModel> products;
  const OfflineOrderBillingPage({
    super.key,
    required this.products,
  });

  @override
  State<OfflineOrderBillingPage> createState() =>
      _OfflineOrderBillingPageState();
}

class _OfflineOrderBillingPageState extends State<OfflineOrderBillingPage> {
  final PdfInvoiceController pdfInvoiceController = PdfInvoiceController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneNumberController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double totalAmount = 0;
  int totalQuantity = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.products.length; i++) {
      totalQuantity += widget.products[i].quantity;
      totalAmount +=
          widget.products[i].unit_price * widget.products[i].quantity;
    }
  }

  Future<void> openPdfFile({required String filePath}) async {
    await OpenDocument.openDocument(filePath: filePath);
  }

  Future<void> sharePdfFileOnWhatsapp({
    required String phoneNumber,
    required String filePath,
  }) async {
    await WhatsappShare.shareFile(
      text: 'Weucart Order Invoice',
      phone: phoneNumber,
      filePath: [filePath],
    );
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
                text: "Create Invoice",
                bgColor: AppColors.primaryButtonColor,
                textColor: AppColors.whiteColor,
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    final data = await pdfInvoiceController.createInvoice(
                      shopModel: dummyShopModel,
                      customerName: _customerNameController.text.trim(),
                      customerPhone: _customerPhoneNumberController.text.trim(),
                      products: widget.products,
                    );
                    String filePath = await pdfInvoiceController.savePdfFile(
                      fileName:
                          "invoice_${_customerPhoneNumberController.text.trim()}",
                      byteList: data,
                    );

                    // Open
                    openPdfFile(filePath: filePath);

                    // Share
                    // sharePdfFileOnWhatsapp(
                    //   phoneNumber: _customerPhoneNumberController.text.trim(),
                    //   filePath: filePath,
                    // );
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
