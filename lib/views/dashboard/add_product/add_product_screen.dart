import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/azure_product_mdoel.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/views/dashboard/add_product/product_search_delegate.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late bool _isLoading;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final ProductController _productController = ProductController();
  final TextEditingController _productISBNController = TextEditingController();

  ProductModel? weucartProductModel;
  AzureProductModel? azureProductModel;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  late bool _showProductFillingDetails;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _showProductFillingDetails = false;
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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryAppBarColor,
        title: Text(
          "Add Product",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.primaryButtonColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryButtonColor.withOpacity(0.8),
                ),
                child: Column(
                  children: [
                    Text(
                      "Scan or enter ISBN code",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: AppColors.blackColor,
                      ),
                    ),
                    TextField(
                      controller: _productISBNController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '',
                        filled: true,
                        fillColor: AppColors.whiteColor,
                        suffixIcon: InkWell(
                          onTap: () async {
                            String? result = await _startBarCodeScan();
                            if (result != null && result != "-1") {
                              _productISBNController.text = result;
                            } else {
                              // ignore: use_build_context_synchronously
                              showCustomDialog(
                                context: context,
                                title: "Scan again",
                                message: "product not found",
                              );
                            }
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.blackColor,
                            size: 20,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryContainerColor,
                          ),
                          gapPadding: 8,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  setState(() {
                    // Reseting
                    _showProductFillingDetails = false;
                    weucartProductModel = null;
                    azureProductModel = null;

                    _productNameController.text = "";
                    _productQuantityController.text = "";
                    _productPriceController.text = "";
                  });

                  if (_productISBNController.text != "") {
                    // Weucart productByISBN API Call
                    ProductModel? productModel =
                        await _productController.getProductByISBN(
                      context: context,
                      productISBN: _productISBNController.text.trim(),
                    );

                    if (productModel != null) {
                      setState(() {
                        weucartProductModel = productModel;

                        _productNameController.text = productModel.name;
                      });
                    } else {
                      // Azure ProductByName API Call Data
                    }

                    setState(() {
                      _showProductFillingDetails = true;
                    });
                  } else {
                    showCustomDialog(
                      context: context,
                      title: "Missing Product ISBN",
                      message:
                          "Enter or search the product ISBN code to add a new product",
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryButtonColor.withOpacity(0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Search Product",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.search,
                        color: AppColors.blackColor,
                        size: 14,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              (_showProductFillingDetails == false)
                  ? Container()
                  : (weucartProductModel != null)
                      ? Form(
                          key: _formKey1,
                          child: Container(
                            width: width,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                TextFormField(
                                  readOnly: true,
                                  controller: _productNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your product name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.whiteColor,
                                    errorStyle:
                                        GoogleFonts.poppins(fontSize: 10),
                                    labelText: 'Product Name *',
                                    labelStyle: GoogleFonts.poppins(
                                      color: AppColors.blackColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryContainerColor,
                                        width: 10,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    contentPadding: const EdgeInsets.all(12.0),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _productQuantityController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your product quantity';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.whiteColor,
                                    errorStyle:
                                        GoogleFonts.poppins(fontSize: 10),
                                    labelText: 'Quantity *',
                                    labelStyle: GoogleFonts.poppins(
                                      color: AppColors.blackColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryContainerColor,
                                        width: 10,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    contentPadding: const EdgeInsets.all(12.0),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _productPriceController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your product unit price';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.whiteColor,
                                    errorStyle:
                                        GoogleFonts.poppins(fontSize: 10),
                                    labelText: 'Product Price *',
                                    labelStyle: GoogleFonts.poppins(
                                      color: AppColors.blackColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryContainerColor,
                                        width: 10,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    contentPadding: const EdgeInsets.all(12.0),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                CustomButton(
                                  text: "Save",
                                  bgColor: AppColors.primaryButtonColor,
                                  textColor: AppColors.whiteColor,
                                  onPress: () async {
                                    if (_formKey1.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                        _showProductFillingDetails = false;
                                      });

                                      // Add Weucart Product Controller -> Add Product API
                                      debugPrint("Product Add API");

                                      await _productController.addProductToShop(
                                        context: context,
                                        weucartProductModel:
                                            weucartProductModel,
                                        azureProductModel: azureProductModel,
                                        quantity: _productQuantityController
                                            .text
                                            .trim(),
                                        price:
                                            _productPriceController.text.trim(),
                                        productISBN:
                                            _productISBNController.text.trim(),
                                      );

                                      setState(() {
                                        _isLoading = false;

                                        weucartProductModel = null;
                                        azureProductModel = null;

                                        _productISBNController.text = "";
                                        _productNameController.text = "";
                                        _productQuantityController.text = "";
                                        _productPriceController.text = "";
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : (azureProductModel == null)
                          ? CustomButton(
                              text: "Search Product By Name",
                              bgColor: AppColors.primaryButtonColor,
                              textColor: AppColors.whiteColor,
                              onPress: () async {
                                AzureProductModel? searchProductModel =
                                    await showSearch(
                                  context: context,
                                  delegate: ProductSearchDelegate(),
                                );

                                if (searchProductModel != null) {
                                  setState(() {
                                    azureProductModel = searchProductModel;

                                    _productNameController.text =
                                        azureProductModel!.product;
                                  });
                                }
                              })
                          : Form(
                              key: _formKey2,
                              child: Container(
                                width: width,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      readOnly: true,
                                      controller: _productNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your product name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.whiteColor,
                                        errorStyle:
                                            GoogleFonts.poppins(fontSize: 10),
                                        labelText: 'Product Name *',
                                        labelStyle: GoogleFonts.poppins(
                                          color: AppColors.blackColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                AppColors.primaryContainerColor,
                                            width: 10,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(12.0),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _productQuantityController,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your product quantity';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.whiteColor,
                                        errorStyle:
                                            GoogleFonts.poppins(fontSize: 10),
                                        labelText: 'Quantity *',
                                        labelStyle: GoogleFonts.poppins(
                                          color: AppColors.blackColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                AppColors.primaryContainerColor,
                                            width: 10,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(12.0),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _productPriceController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your product unit price';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.whiteColor,
                                        errorStyle:
                                            GoogleFonts.poppins(fontSize: 10),
                                        labelText: 'Product Price *',
                                        labelStyle: GoogleFonts.poppins(
                                          color: AppColors.blackColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                AppColors.primaryContainerColor,
                                            width: 10,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(12.0),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    CustomButton(
                                      text: "Save",
                                      bgColor: AppColors.primaryButtonColor,
                                      textColor: AppColors.whiteColor,
                                      onPress: () async {
                                        if (_formKey2.currentState!
                                            .validate()) {
                                          setState(() {
                                            _isLoading = true;
                                          });

                                          // Add Azure Product Controller -> Add Product API
                                          debugPrint("Product Add API");

                                          await _productController
                                              .addProductToShop(
                                            context: context,
                                            weucartProductModel:
                                                weucartProductModel!,
                                            azureProductModel:
                                                azureProductModel!,
                                            quantity: _productQuantityController
                                                .text
                                                .trim(),
                                            price: _productPriceController.text
                                                .trim(),
                                            productISBN: _productISBNController
                                                .text
                                                .trim(),
                                          );

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
            ],
          ),
        ),
      ),
    );
  }
}
