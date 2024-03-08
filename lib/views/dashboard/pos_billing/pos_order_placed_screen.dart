import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_document/open_document.dart';
import 'package:weu_cart_seller/core/colors.dart';
import 'package:weu_cart_seller/views/dashboard/dashboard_screen.dart';
import 'package:weu_cart_seller/views/widgets/custom_button.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';

class POSOrderPlacedScreen extends StatelessWidget {
  final String filePath;
  final String customerPhone;
  const POSOrderPlacedScreen({
    super.key,
    required this.filePath,
    required this.customerPhone,
  });

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
      backgroundColor: AppColors.primaryButtonColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: size.height * 0.15),
          Animate(
            effects: [FadeEffect(delay: 1000.ms, duration: 1500.ms)],
            child: SizedBox(
              height: 120,
              width: 120,
              child: Icon(
                Icons.check_circle,
                size: 90,
                color: AppColors.whiteColor,
              ),
            ),
            onPlay: (controller) => controller.repeat(),
          ),
          const SizedBox(height: 8),
          Text(
            "POS Order placed",
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Your order reciept has been generated.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.15),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Close",
                    textColor: AppColors.blackColor,
                    bgColor: AppColors.whiteColor,
                    onPress: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                          return const DashboardScreen(pageIndex: 2);
                        }),
                        (route) => false,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: "Open",
                    textColor: AppColors.blackColor,
                    bgColor: AppColors.whiteColor,
                    onPress: () async {
                      await openPdfFile(filePath: filePath);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: "Share",
                    textColor: AppColors.blackColor,
                    bgColor: AppColors.whiteColor,
                    onPress: () async {
                      await sharePdfFileOnWhatsapp(
                        phoneNumber: customerPhone,
                        filePath: filePath,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
