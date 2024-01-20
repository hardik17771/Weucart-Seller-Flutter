import 'package:flutter/material.dart';
import 'package:weu_cart_seller/controllers/dashboard/product_controller.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class ProductSearchDelegate extends SearchDelegate {
  ProductSearchDelegate();
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
    // return const SizedBox();
    return FutureBuilder(
      future: _productController.searchProductByName(
          context: context, query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: ((context, index) {
              ProductModel product = products[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.featured_img),
                ),
                title: Text(product.name),
                onTap: () {},
              );
            }),
          );
        } else {
          return const CustomLoader();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
    //   return FutureBuilder(
    //     future: _productController.searchProductByName(
    //         context: context, query: query),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         List<ProductModel> products = snapshot.data!;
    //         return ListView.builder(
    //           itemCount: products.length,
    //           itemBuilder: ((context, index) {
    //             ProductModel product = products[index];
    //             return ListTile(
    //               leading: CircleAvatar(
    //                 backgroundImage: NetworkImage(product.featured_img),
    //               ),
    //               title: Text(product.name),
    //               onTap: () {},
    //             );
    //           }),
    //         );
    //       } else {
    //         return const CustomLoader();
    //       }
    //     },
    //   );
    // }
  }
}
