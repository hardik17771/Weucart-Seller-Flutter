import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weu_cart_seller/controllers/app_info_controller.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/models/app_info/terms_and_coditions_model.dart';
import 'package:weu_cart_seller/views/widgets/custom_loader.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final AppInfoController _appInfoController = AppInfoController();

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
          "Terms And Conditions",
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
          width: size.width,
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<TermsAndConditionsModel?>(
            future: _appInfoController.getTermsAndConditionsData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomLoader();
              } else if (snapshot.hasData) {
                TermsAndConditionsModel? model = snapshot.data;
                if (model == null) {
                  return const Center(
                    child: Text("No Data"),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          model.title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        model.content,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  );
                }
              } else {
                return const Center(
                  child: Text("No Data"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
