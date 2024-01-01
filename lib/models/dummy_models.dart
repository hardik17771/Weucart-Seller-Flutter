import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/models/address_model.dart';
import 'package:weu_cart_seller/models/app_info/faq_model.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

ShopModel dummyShopModel = ShopModel(
  shopId: 9,
  shopUid: "shopUid",
  categoryId: ["1", "2"],
  name: "GJ Store",
  ownerName: "GJ",
  phoneNumber: "9999999999",
  emailId: "gj@gmail.com",
  logo: AppConstants.defaultLogoImage,
  image: AppConstants.defaultShopImage,
  address: "address",
  city: "city",
  pincode: "pincode",
  latitude: "45",
  longitude: "32",
  rating: "4.3",
  deliveryTime: "60 Mins",
  onlineStatus: "Online",
  deviceToken: "deviceToken",
);

UserAddressModel dummyUserAddressModel = UserAddressModel(
  latitude: "56.5",
  longitude: "54.4",
  address: "Kalani Nagar, Indore",
  city: "Indore",
  state: "",
  country: "",
  pincode: "",
  id: "",
);

ProductModel dummmyProductModel = ProductModel(
  product_id: 9,
  name: "Bisk Club - Rusk bake",
  quantity: 1,
  added_by: "",
  category_id: 9,
  main_subcategory_id: 9,
  shop_id: 9,
  latitude: "31.70746075",
  longitude: "76.5263285338436",
  user_id: "9",
  num_of_sale: 9,
  brand_id: "9",
  photos:
      "https://cdn.shopify.com/s/files/1/0434/5475/9072/products/IS-308_large.jpg?v=1667581410",
  thumbnail_img:
      "https://cdn.shopify.com/s/files/1/0434/5475/9072/products/IS-308_large.jpg?v=1667581410",
  featured_img:
      "https://cdn.shopify.com/s/files/1/0434/5475/9072/products/IS-308_large.jpg?v=1667581410",
  flash_deal_img:
      "https://cdn.shopify.com/s/files/1/0434/5475/9072/products/IS-308_large.jpg?v=1667581410",
  video_provider: "",
  video_link: "",
  tags: "",
  description: "",
  unit_price: 70,
  purchase_price: 40,
  choice_options: "",
  colors: "",
  variations: "",
  todays_deal: 10,
  published: DateTime.now().microsecondsSinceEpoch,
  featured: 123456,
  current_stock: 9,
  unit: "9",
  discount: 9,
  discount_type: "",
  tax: 9,
  tax_type: "GST",
  shipping_type: "",
  shipping_cost: 9,
  meta_title: "",
  meta_description: "",
  meta_img: "",
  pdf: "",
  slug: "",
  rating: 4,
);

OrderModel dummyOrderModel = OrderModel(
  customerName: "Gautam Jain",
  customerAddressModel: dummyUserAddressModel,
  customerPhone: "+919640414912",
  orderAmount: "897",
  products: [
    dummmyProductModel,
    dummmyProductModel,
  ],
  orderStatus: "Delivered",
  orderDeliveryTime: DateTime.now(),
  paymentMode: "Paytm",
);

FAQModel dummyFAQModel = FAQModel(
  id: 9,
  question: "What is our Return Policy?",
  answer:
      "Our return policy allows customers to request full or partial refunds for undesired items or unused in-app purchases within 30 days of purchase. Refunds are exclusive to the original payment method and will not be restocked.",
);
