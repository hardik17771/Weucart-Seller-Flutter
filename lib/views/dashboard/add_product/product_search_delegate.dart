import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/product/azure_product_mdoel.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class ProductSearchDelegate extends SearchDelegate<AzureProductModel> {
  ProductSearchDelegate({AzureProductModel? azureProductModel});

  final ProductController _productController = ProductController();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<AzureProductModel>>(
      future: _productController.searchAzureProductByName(
        context: context,
        query: query,
      ),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<AzureProductModel> products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: ((context, index) {
              return ListTile(
                leading: Icon(
                  Icons.trending_up,
                  size: 16,
                  color: AppColors.primaryButtonColor,
                ),
                title: Text(
                  products[index].product,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  close(context, products[index]);
                },
              );
            }),
          );
        } else {
          return const CustomLoader();
        }
      }),
    );
  }
}
