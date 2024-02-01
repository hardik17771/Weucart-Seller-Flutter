import 'package:weu_cart_seller/models/address_model.dart';
import 'package:weu_cart_seller/models/app_info/faq_model.dart';
import 'package:weu_cart_seller/models/azure_product_mdoel.dart';
import 'package:weu_cart_seller/models/order_model.dart';
import 'package:weu_cart_seller/models/product_model.dart';

UserAddressModel dummyAddressModel = UserAddressModel(
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
  added_by: "",
  category_id: 9,
  main_subcategory_id: 9,
  shops: [],
  isbn: '',
  total_quantity: 1,
  num_of_sale: 9,
  brand_id: "9",
  photos: [],
  thumbnail_img:
      "https://cdn.shopify.com/s/files/1/0434/5475/9072/products/IS-308_large.jpg?v=1667581410",
  description: "",
  unit_price: 70,
  mrp_price: 89,
);

AzureProductModel dummyAzureProductModel = AzureProductModel(
  indexx: 53,
  product: "Acne & Oil Control Face Wash",
  category: "Beauty & Hygiene",
  sub_category: "Men's Grooming",
  brand: "Red Hunt",
  sale_price: 80,
  market_price: 100,
  typee: "Face & Body",
  rating: 4,
  descriptionn:
      "Natural mineral kaolin deep cleans removes dirt, pollution and bacteria. Added sliver resists the impact and spread of acne causing bacteria",
);

OrderModel dummyOrderModel = OrderModel(
  customerName: "Gautam Jain",
  customerAddressModel: dummyAddressModel,
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
