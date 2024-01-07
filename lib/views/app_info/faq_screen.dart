import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weu_cart_seller/controllers/dashboard/app_info_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/app_info/faq_model.dart';
import 'package:weu_cart_seller/views/app_info/widgets/faq_card.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final AppInfoController _appInfoController = AppInfoController();
  bool visiblity = false;
  late String indexts = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "FAQ",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
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
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<FAQModel>>(
            future: _appInfoController.getFAQData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomLoader();
              } else if (snapshot.hasData) {
                List<FAQModel> faqsList = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: faqsList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: FAQCard(
                        question: faqsList[index].question,
                        answer: faqsList[index].answer,
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No FAQ's"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
