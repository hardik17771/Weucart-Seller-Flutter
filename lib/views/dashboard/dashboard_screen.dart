import 'package:flutter/material.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/views/dashboard/pos_billing/qr_scanning_screen.dart';
import 'package:weu_cart_seller/views/dashboard/add_product/add_product_screen.dart';
import 'package:weu_cart_seller/views/dashboard/home_screen.dart';
import 'package:weu_cart_seller/views/dashboard/shop_analytics_screen.dart';
import 'package:weu_cart_seller/views/dashboard/shop_database/shop_database_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({
    required this.pageIndex,
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeScreen(),
      const AddProductScreen(),
      const QrScanningScreen(),
      const ShopAnalyticsScreen(),
      const ShopDatabaseScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      body: pages[_pageIndex],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.15),
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: BottomNavigationBar(
              backgroundColor: AppColors.primaryButtonColor,
              selectedItemColor: AppColors.blackColor,
              unselectedItemColor: AppColors.whiteColor,
              unselectedFontSize: 0,
              selectedFontSize: 0,
              onTap: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              currentIndex: _pageIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: "Add",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code),
                  label: "POS",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_outlined),
                  label: "Analytics",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dataset_outlined),
                  label: "Database",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
