import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weu_cart_seller/controllers/dashboard/category_controller.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/controllers/file_upload_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/utils.dart';
import 'package:weu_cart_seller/models/category/main_category_model.dart';
import 'package:weu_cart_seller/models/category/main_sub_category_model.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';
import 'package:weu_cart_seller/models/product/azure_product_mdoel.dart';
import 'package:weu_cart_seller/models/product/product_model.dart';
import 'package:weu_cart_seller/views/dashboard/add_product/product_search_delegate.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late bool _isLoading;
  final _formKeySearchProduct = GlobalKey<FormState>();
  final _formKeyWeucartProduct = GlobalKey<FormState>();
  final _formKeyAzureProduct = GlobalKey<FormState>();
  final _formKeyManualProduct = GlobalKey<FormState>();

  final FileUploadController _fileUploadController = FileUploadController();
  final ProductController _productController = ProductController();
  final CategoryController _categoryController = CategoryController();

  final TextEditingController _productISBNController = TextEditingController();

  File? _productImage;
  MainCategoryModel? _selectedMainCategoryModel;
  MainSubCategoryModel? _selectedMainSubCategoryModel;
  ProductModel? weucartProductModel;
  AzureProductModel? azureProductModel;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productMRPController = TextEditingController();

  late bool _showProductFillingDetails;
  late bool _isProductAddedManually;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _isProductAddedManually = false;
    _showProductFillingDetails = false;
  }

  void showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Choose image source",
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  File? pickedImage =
                      await pickImage(imageSource: ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      _productImage = pickedImage;
                    });
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.photo,
                      size: 20,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Gallery",
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  File? pickedImage =
                      await pickImage(imageSource: ImageSource.camera);
                  if (pickedImage != null) {
                    _productImage = pickedImage;
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_a_photo_rounded,
                      size: 20,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Camera",
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
                    Form(
                      key: _formKeySearchProduct,
                      child: TextFormField(
                        controller: _productISBNController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.length != 13) {
                            return 'Enter a ISBN Code';
                          }
                          return null;
                        },
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  if (_formKeySearchProduct.currentState!.validate()) {
                    setState(() {
                      // Reseting
                      _showProductFillingDetails = false;
                      weucartProductModel = null;
                      azureProductModel = null;
                      _isProductAddedManually = false;

                      _productImage = null;
                      _selectedMainCategoryModel = null;
                      _selectedMainSubCategoryModel = null;

                      _productNameController.text = "";
                      _productQuantityController.text = "";
                      _productPriceController.text = "";
                      _productDescriptionController.text = "";
                      _productMRPController.text = "";
                    });

                    // ---- Searching Product Data in Weucart-Products-DB ------------------->

                    ProductModel? productModel =
                        await _productController.getProductByISBN(
                      context: context,
                      productISBN: _productISBNController.text.trim(),
                    );

                    if (productModel != null) {
                      // Filling with Weucart Product Data Details
                      setState(() {
                        weucartProductModel = productModel;

                        _productNameController.text = productModel.name;
                      });
                    } else {
                      // 1. Search Azure ProductByName
                      // 2. Manually Product Details
                    }

                    setState(() {
                      _showProductFillingDetails = true;
                    });
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
                          key: _formKeyWeucartProduct,
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
                                    if (_formKeyWeucartProduct.currentState!
                                        .validate()) {
                                      setState(() {
                                        _isLoading = true;
                                        _showProductFillingDetails = false;
                                      });

                                      debugPrint("Product Add API");

                                      await _productController
                                          .addWeucartProductToShop(
                                        context: context,
                                        weucartProductModel:
                                            weucartProductModel!,
                                        quantity: int.parse(
                                            _productQuantityController.text
                                                .trim()),
                                        price: int.parse(_productPriceController
                                            .text
                                            .trim()),
                                        productISBN:
                                            _productISBNController.text.trim(),
                                      );

                                      setState(() {
                                        _isLoading = false;

                                        weucartProductModel = null;
                                        azureProductModel = null;

                                        _productImage = null;
                                        _selectedMainCategoryModel = null;
                                        _selectedMainSubCategoryModel = null;

                                        _productISBNController.text = "";
                                        _productNameController.text = "";
                                        _productQuantityController.text = "";
                                        _productPriceController.text = "";
                                        _productDescriptionController.text = "";
                                        _productMRPController.text = "";
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : (azureProductModel == null &&
                              _isProductAddedManually == false)
                          ? Column(
                              children: [
                                CustomButton(
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
                                  },
                                ),
                                const SizedBox(height: 12),
                                CustomButton(
                                  text: "Manually add Product Details",
                                  bgColor: AppColors.primaryButtonColor,
                                  textColor: AppColors.whiteColor,
                                  onPress: () async {
                                    setState(() {
                                      _isProductAddedManually = true;
                                    });
                                  },
                                ),
                              ],
                            )
                          : (azureProductModel != null)
                              ? Form(
                                  key: _formKeyAzureProduct,
                                  child: Container(
                                    width: width,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          readOnly: true,
                                          controller: _productNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product name';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Product Name *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          controller:
                                              _productQuantityController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product quantity';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Quantity *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product unit price';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Product Price *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        FutureBuilder(
                                          future: _categoryController
                                              .getMainCategoryList(
                                                  context: context),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<MainCategoryModel>
                                                  _mainCategoryList =
                                                  snapshot.data!;

                                              return DropdownButtonFormField<
                                                  MainCategoryModel>(
                                                alignment: Alignment.centerLeft,
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Select a category';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      AppColors.whiteColor,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    color: AppColors.blackColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText: "Choose a category",
                                                  contentPadding:
                                                      const EdgeInsets.all(4),
                                                ),
                                                value:
                                                    _selectedMainCategoryModel,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedMainSubCategoryModel =
                                                        null;
                                                    _selectedMainCategoryModel =
                                                        newValue;
                                                  });
                                                },
                                                items: _mainCategoryList.map(
                                                    (MainCategoryModel value) {
                                                  return DropdownMenuItem<
                                                      MainCategoryModel>(
                                                    value: value,
                                                    child: Text(
                                                      value.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        (_selectedMainCategoryModel == null)
                                            ? const SizedBox()
                                            : Column(
                                                children: [
                                                  FutureBuilder(
                                                    future: _categoryController
                                                        .getMainSubCategoryList(
                                                      mainCategoryModel:
                                                          _selectedMainCategoryModel!,
                                                      context: context,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        List<MainSubCategoryModel>
                                                            _mainSubCategoryList =
                                                            snapshot.data!;

                                                        return DropdownButtonFormField<
                                                            MainSubCategoryModel?>(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return 'Select a sub category';
                                                            }
                                                            return null;
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                const OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    15),
                                                              ),
                                                            ),
                                                            filled: true,
                                                            fillColor: AppColors
                                                                .whiteColor,
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .poppins(
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            hintText:
                                                                "Choose a sub category",
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                          ),
                                                          value:
                                                              _selectedMainSubCategoryModel,
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              _selectedMainSubCategoryModel =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: _mainSubCategoryList
                                                              .map(
                                                                  (MainSubCategoryModel
                                                                      value) {
                                                            return DropdownMenuItem<
                                                                MainSubCategoryModel>(
                                                              value: value,
                                                              child: Text(
                                                                value.name,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        );
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(height: 12),
                                                ],
                                              ),
                                        (_productImage != null)
                                            ? GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    _productImage = null;
                                                  });
                                                },
                                                child: Container(
                                                  height: 108,
                                                  width: 108,
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          _productImage!),
                                                      fit: BoxFit.fill,
                                                      opacity: 0.75,
                                                    ),
                                                    // color: AppColors.blue600,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                      color: AppColors
                                                          .blackColor
                                                          .withOpacity(0.75),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  showImageDialog();
                                                  ;
                                                },
                                                child: Container(
                                                  height: 108,
                                                  width: 108,
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .primaryButtonColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .whiteColor,
                                                        size: 32,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "Add Image",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        const SizedBox(height: 12),
                                        CustomButton(
                                          text: "Save",
                                          bgColor: AppColors.primaryButtonColor,
                                          textColor: AppColors.whiteColor,
                                          onPress: () async {
                                            if (_formKeyAzureProduct
                                                .currentState!
                                                .validate()) {
                                              if (_productImage == null) {
                                                showCustomDialog(
                                                  context: context,
                                                  title: "Add Product Image",
                                                  message:
                                                      "Select a product image to continue",
                                                );
                                              } else {
                                                setState(() {
                                                  _isLoading = true;
                                                  _showProductFillingDetails =
                                                      false;
                                                });

                                                Map<String, dynamic>?
                                                    imageData =
                                                    await _fileUploadController
                                                        .uploadProductImage(
                                                  context: context,
                                                  file: _productImage!,
                                                );

                                                if (imageData != null) {
                                                  debugPrint(
                                                      "Azure Product Add API");
                                                  debugPrint(
                                                      imageData.toString());

                                                  // ignore: use_build_context_synchronously
                                                  await _productController
                                                      .addAzureProductToShop(
                                                    context: context,
                                                    azureProductModel:
                                                        azureProductModel!,
                                                    quantity:
                                                        _productQuantityController
                                                            .text
                                                            .trim(),
                                                    price:
                                                        _productPriceController
                                                            .text
                                                            .trim(),
                                                    productISBN:
                                                        _productISBNController
                                                            .text
                                                            .trim(),
                                                    category_id:
                                                        _selectedMainCategoryModel!
                                                            .category_id,
                                                    main_subcategory_id:
                                                        _selectedMainSubCategoryModel!
                                                            .main_subcategory_id,
                                                    imageUrl:
                                                        imageData["image_url"],
                                                  );
                                                }

                                                setState(() {
                                                  _isLoading = false;

                                                  weucartProductModel = null;
                                                  azureProductModel = null;

                                                  _productImage = null;
                                                  _selectedMainCategoryModel =
                                                      null;
                                                  _selectedMainSubCategoryModel =
                                                      null;

                                                  _productISBNController.text =
                                                      "";
                                                  _productNameController.text =
                                                      "";
                                                  _productQuantityController
                                                      .text = "";
                                                  _productPriceController.text =
                                                      "";
                                                  _productDescriptionController
                                                      .text = "";
                                                  _productMRPController.text =
                                                      "";
                                                });
                                              }
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 100),
                                      ],
                                    ),
                                  ),
                                )
                              : Form(
                                  key: _formKeyManualProduct,
                                  child: Container(
                                    width: width,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          controller: _productNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product name';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Product Name *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          controller:
                                              _productQuantityController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product quantity';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Quantity *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product unit price';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Product Price *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          controller: _productMRPController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product MRP';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Product MRP *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          controller:
                                              _productDescriptionController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter your product description';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.whiteColor,
                                            errorStyle: GoogleFonts.poppins(
                                                fontSize: 10),
                                            labelText: 'Product Description *',
                                            labelStyle: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryContainerColor,
                                                width: 10,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        FutureBuilder(
                                          future: _categoryController
                                              .getMainCategoryList(
                                                  context: context),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<MainCategoryModel>
                                                  _mainCategoryList =
                                                  snapshot.data!;

                                              return DropdownButtonFormField<
                                                  MainCategoryModel>(
                                                alignment: Alignment.centerLeft,
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Select a category';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      AppColors.whiteColor,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    color: AppColors.blackColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText: "Choose a category",
                                                  contentPadding:
                                                      const EdgeInsets.all(4),
                                                ),
                                                value:
                                                    _selectedMainCategoryModel,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedMainSubCategoryModel =
                                                        null;
                                                    _selectedMainCategoryModel =
                                                        newValue;
                                                  });
                                                },
                                                items: _mainCategoryList.map(
                                                    (MainCategoryModel value) {
                                                  return DropdownMenuItem<
                                                      MainCategoryModel>(
                                                    value: value,
                                                    child: Text(
                                                      value.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        (_selectedMainCategoryModel == null)
                                            ? const SizedBox()
                                            : Column(
                                                children: [
                                                  FutureBuilder(
                                                    future: _categoryController
                                                        .getMainSubCategoryList(
                                                      mainCategoryModel:
                                                          _selectedMainCategoryModel!,
                                                      context: context,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        List<MainSubCategoryModel>
                                                            _mainSubCategoryList =
                                                            snapshot.data!;

                                                        return DropdownButtonFormField<
                                                            MainSubCategoryModel?>(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return 'Select a sub category';
                                                            }
                                                            return null;
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                const OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    15),
                                                              ),
                                                            ),
                                                            filled: true,
                                                            fillColor: AppColors
                                                                .whiteColor,
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .poppins(
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            hintText:
                                                                "Choose a sub category",
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                          ),
                                                          value:
                                                              _selectedMainSubCategoryModel,
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              _selectedMainSubCategoryModel =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: _mainSubCategoryList
                                                              .map(
                                                                  (MainSubCategoryModel
                                                                      value) {
                                                            return DropdownMenuItem<
                                                                MainSubCategoryModel>(
                                                              value: value,
                                                              child: Text(
                                                                value.name,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        );
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(height: 12),
                                                ],
                                              ),
                                        (_productImage != null)
                                            ? GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    _productImage = null;
                                                  });
                                                },
                                                child: Container(
                                                  height: 108,
                                                  width: 108,
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          _productImage!),
                                                      fit: BoxFit.fill,
                                                      opacity: 0.75,
                                                    ),
                                                    // color: AppColors.blue600,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                      color: AppColors
                                                          .blackColor
                                                          .withOpacity(0.75),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  showImageDialog();
                                                },
                                                child: Container(
                                                  height: 108,
                                                  width: 108,
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .primaryButtonColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .whiteColor,
                                                        size: 32,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "Add Image",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        const SizedBox(height: 12),
                                        CustomButton(
                                          text: "Save",
                                          bgColor: AppColors.primaryButtonColor,
                                          textColor: AppColors.whiteColor,
                                          onPress: () async {
                                            if (_formKeyManualProduct
                                                .currentState!
                                                .validate()) {
                                              if (_productImage == null) {
                                                showCustomDialog(
                                                  context: context,
                                                  title: "Add Product Image",
                                                  message:
                                                      "Select a Product Image to continue",
                                                );
                                              } else {
                                                setState(() {
                                                  _isLoading = true;
                                                  _showProductFillingDetails =
                                                      false;
                                                });

                                                Map<String, dynamic>?
                                                    imageData =
                                                    await _fileUploadController
                                                        .uploadProductImage(
                                                  context: context,
                                                  file: _productImage!,
                                                );

                                                if (imageData != null) {
                                                  debugPrint(
                                                      "Manual Product Add API");

                                                  debugPrint(
                                                      imageData.toString());

                                                  // ignore: use_build_context_synchronously
                                                  await _productController
                                                      .addManualProductToShop(
                                                    context: context,
                                                    name: _productNameController
                                                        .text
                                                        .trim(),
                                                    description:
                                                        _productDescriptionController
                                                            .text
                                                            .trim(),
                                                    quantity: int.parse(
                                                        _productQuantityController
                                                            .text
                                                            .trim()),
                                                    unit_price: int.parse(
                                                        _productPriceController
                                                            .text
                                                            .trim()),
                                                    productISBN:
                                                        _productISBNController
                                                            .text
                                                            .trim(),
                                                    market_price: int.parse(
                                                        _productMRPController
                                                            .text
                                                            .trim()),
                                                    category_id:
                                                        _selectedMainCategoryModel!
                                                            .category_id,
                                                    main_subcategory_id:
                                                        _selectedMainSubCategoryModel!
                                                            .main_subcategory_id,
                                                    imageUrl:
                                                        imageData["image_url"],
                                                  );
                                                }

                                                setState(() {
                                                  _isLoading = false;

                                                  weucartProductModel = null;
                                                  azureProductModel = null;

                                                  _productImage = null;
                                                  _selectedMainCategoryModel =
                                                      null;
                                                  _selectedMainSubCategoryModel =
                                                      null;
                                                  _productISBNController.text =
                                                      "";
                                                  _productNameController.text =
                                                      "";
                                                  _productQuantityController
                                                      .text = "";
                                                  _productPriceController.text =
                                                      "";
                                                  _productDescriptionController
                                                      .text = "";
                                                  _productMRPController.text =
                                                      "";
                                                });
                                              }
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 108),
                                      ],
                                    ),
                                  ),
                                )
            ],
          ),
        ),
      ),
    );
  }
}
