import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weu_cart_seller/controllers/dashboard/order_controller.dart';
import 'package:weu_cart_seller/controllers/seller_controller.dart';
import 'package:weu_cart_seller/controllers/shop_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';
import 'package:weu_cart_seller/views/app_info/about_us_screen.dart';
import 'package:weu_cart_seller/views/app_info/faq_screen.dart';
import 'package:weu_cart_seller/views/app_info/privacy_and_policy_screen.dart';
import 'package:weu_cart_seller/views/app_info/terms_and_condition_screen.dart';
import 'package:weu_cart_seller/views/dashboard/dashboard_screen.dart';
import 'package:weu_cart_seller/views/dashboard/orders/widgets/live_order_card.dart';
import 'package:weu_cart_seller/views/dashboard/orders/past_orders_screen.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late io.Socket socket;
  final SellerController _sellerController = SellerController();
  final ShopController _shopController = ShopController();
  final OrderController _orderController = OrderController();
  List<String> liveOrderIds = [];

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    // socket = io.io(
    //   AppConstants.backendUrl,
    //   <String, dynamic>{
    //     'transports': ['websocket'],
    //     'autoConnect': true,
    //   },
    // );

    // socket.connect();
    // socket.onConnect((_) {
    //   debugPrint('Connected to the socket server');
    // });
    // socket.onDisconnect((_) {
    //   debugPrint('Disconnected from the socket server');
    // });

    // socket.on('orderPlaced', (data) {
    //   debugPrint('Received order id: $data');
    //   setState(() {
    //     liveOrderIds.add(data);
    //   });
    // });
  }

  @override
  void dispose() {
    // socket.disconnect();
    // socket.dispose();
    super.dispose();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: FutureBuilder<ShopModel?>(
          future: _shopController.getLocalShopData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ShopModel shopModel = snapshot.data!;
              // debugPrint(liveOrderIds.toString());
              debugPrint(shopModel.status.toString());

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryButtonColor,
                            AppColors.primaryButtonColor.withOpacity(0.8),
                          ],
                          end: Alignment.bottomRight,
                          begin: Alignment.topLeft,
                        ),
                        color: AppColors.primaryButtonColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(42),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Builder(builder: (context) {
                                    return IconButton(
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer(),
                                      icon: Icon(
                                        Icons.menu,
                                        size: 24,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                      ),
                                    );
                                  }),
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Good Morning",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                      Text(
                                        shopModel.name,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColors.blackColor,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Switch(
                                activeColor: AppColors.whiteColor,
                                activeTrackColor: AppColors.greenColor,
                                value: (shopModel.status == "Online")
                                    ? true
                                    : false,
                                onChanged: (value) async {
                                  await _shopController.updateShopOnlineStatus(
                                    context: context,
                                    shopModel: shopModel,
                                    status:
                                        (value == true) ? "Online" : "Offline",
                                  );

                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Welcome to WeuCart Seller",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "You may have new orders!",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                refresh();
                              },
                              child: Icon(
                                size: 28,
                                Icons.refresh,
                                color: AppColors.primaryButtonColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Live Orders",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          FutureBuilder<List<OrderModel>>(
                            future: _orderController.getShopOrdersByStatus(
                              context: context,
                              shopModel: shopModel,
                              orderStatus: "current",
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<OrderModel> currentOrders = snapshot.data!;
                                if (currentOrders.isEmpty) {
                                  return const SizedBox();
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: currentOrders.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      OrderModel orderModel =
                                          currentOrders[index];
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        child: LiveOrderCard(
                                          orderModel: orderModel,
                                          notifyParent: refresh,
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                return const CustomLoader();
                              }
                            },
                          ),
                          Container(
                            width: size.width,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Waiting for more orders",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 7,
                                color: AppColors.blackColor.withOpacity(0.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox(
                height: size.height,
                width: size.width,
                child: const CustomLoader(),
              );
            }
          }),
      drawer: Drawer(
        child: drawerDashboard(),
      ),
    );
  }

  Widget drawerDashboard() {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8),
      width: size.width,
      height: size.height,
      child: Column(
        children: <Widget>[
          colum0(),
          const SizedBox(height: 16),
          colum1(),
          colum2(),
          colum3(),
          colum4(),
          colum5(),
          colum6(),
          colum7(),
          colum8(),
          colum9()
        ],
      ),
    );
  }

  Widget colum0() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/icons/weucartLogo.png"),
              ),
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            "Hello Seller",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // _scaffoldKey.currentState!.closeDrawer();
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 25,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget colum1() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const PastOrdersScreen();
            },
          ),
        );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset("assets/icons/usericonss.svg"),
          ),
          const SizedBox(width: 16),
          Text(
            "Past Orders",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget colum2() {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MyProfileScreen(),
        //   ),
        // );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset("assets/icons/usericonss.svg"),
          ),
          const SizedBox(width: 16),
          Text(
            "Seller Profile",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget colum3() {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ManagePaymentsScreen(),
        //   ),
        // );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset("assets/icons/managepaymenticonss.svg"),
          ),
          const SizedBox(width: 16),
          Text(
            "Manage Payment",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget colum4() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FAQScreen(),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset("assets/icons/faqsicon2.svg"),
          ),
          const SizedBox(width: 16),
          Text(
            "FAQ",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget colum5() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TermsAndConditionsScreen(),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: Image.asset("assets/icons/termsandconditionsicons3.png"),
          ),
          const SizedBox(width: 16),
          Text(
            "Terms and Condition",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget colum6() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PrivacyAndPolicyScreen(),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: Image.asset("assets/icons/PRICAVYANDPOLICYICONSS.png"),
          ),
          const SizedBox(width: 16),
          Text(
            "Privacy & Policy",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget colum7() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(pageIndex: 3),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset("assets/icons/helpandsupporticons.svg"),
          ),
          const SizedBox(width: 16),
          Text(
            "Help & Support",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget colum8() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutUsScreen(),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset("assets/icons/helpandsupporticons.svg"),
          ),
          const SizedBox(width: 16),
          Text(
            "About us",
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget colum9() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showLogOutDialog();
        },
        child: Container(
          alignment: Alignment.topRight,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 48,
                width: 48,
                child: SvgPicture.asset("assets/icons/usericonss.svg"),
              ),
              const SizedBox(width: 16),
              Text(
                "Logout",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(
              "Do You Want To Logout",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: AppColors.blackColor,
              ),
            ),
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  _sellerController.logOut(context: context);
                },
                child: Container(
                  height: 36,
                  width: 80,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primaryButtonColor,
                  ),
                  child: Center(
                    child: Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 36,
                  width: 80,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.secondryButtonColor,
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
