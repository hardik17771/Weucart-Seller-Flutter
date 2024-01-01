import 'package:weu_cart_seller/models/app_info/aboutus_model.dart';
import 'package:weu_cart_seller/models/app_info/faq_model.dart';
import 'package:weu_cart_seller/models/app_info/privacy_and_policy_model.dart';
import 'package:weu_cart_seller/models/app_info/terms_and_coditions_model.dart';
import 'package:weu_cart_seller/models/dummy_models.dart';

class AppInfoController {
  Future<List<FAQModel>> getFAQData() async {
    List<FAQModel> faqsList = [];

    faqsList.add(dummyFAQModel);
    faqsList.add(dummyFAQModel);

    return faqsList;
  }

  Future<AboutUsModel?> getAboutUsData() async {
    AboutUsModel? aboutUsModel = AboutUsModel(
      id: 9,
      title: "WeuCart",
      content:
          "An ecommerce app allows users to shop online, browse product catalogs, create wish lists, add items to a cart, and complete purchases. It also provides payment processing, shipping, and order management capabilities.",
    );
    return aboutUsModel;
  }

  Future<TermsAndConditionsModel> getTermsAndConditionsData() async {
    TermsAndConditionsModel? termsAndConditionModel = TermsAndConditionsModel(
      id: 9,
      title: "WeuCart",
      content:
          "A Terms and Conditions agreement (T&C), also known as a Terms of Service or Terms of Use) agreement, is the legal agreement that sets forth the rules, requirements, and standards of using a website or a mobile/desktop app.",
    );
    return termsAndConditionModel;
  }

  Future<PrivacyAndPolicyModel?> getPrivacyAndPolicyData() async {
    PrivacyAndPolicyModel privacyAndPolicyModel = PrivacyAndPolicyModel(
      id: 9,
      title: "WeuCart",
      content:
          "Privacy policies and terms of service (ToS) are legal documents that outline the rules and regulations for the use of a website or app. They typically provide information about how user data will be collected, used, and protected, as well as any limitations on liability for the company providing the service.",
    );
    return privacyAndPolicyModel;
  }
}
