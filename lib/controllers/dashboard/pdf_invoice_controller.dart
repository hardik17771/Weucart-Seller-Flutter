import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:weu_cart_seller/models/product_model.dart';
import 'package:weu_cart_seller/models/shop_model.dart';

class CustomRow {
  final String name;
  final String quantity;
  final String unitPrice;
  final String totalPrice;
  CustomRow({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });
}

class PdfInvoiceController {
  Future<Uint8List> createInvoice({
    required ShopModel shopModel,
    required String customerName,
    required String customerPhone,
    required List<ProductModel> products,
  }) async {
    final pdf = pw.Document();

    final List<CustomRow> elements = [
      CustomRow(
        name: "Product Name",
        quantity: "Quantity",
        unitPrice: "Unit Price",
        totalPrice: "Total Price",
      ),
      for (var product in products)
        CustomRow(
          name: product.name,
          quantity: product.quantity.toString(),
          unitPrice: product.unit_price.toString(),
          totalPrice: "${product.quantity * product.unit_price}",
        ),
      CustomRow(
        name: "Total Amount",
        quantity: "",
        unitPrice: "",
        totalPrice: "Rs. ${getSubTotal(products)}",
      ),
    ];

    final image =
        (await rootBundle.load("assets/icons/icon.png")).buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(pw.MemoryImage(image),
                          width: 80, height: 80, fit: pw.BoxFit.cover),
                      pw.SizedBox(width: 16),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            shopModel.shopName,
                            style: const pw.TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          pw.Text(
                            "Order Invoice",
                            style: const pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(shopModel.addressModel.address),
                      pw.Text(shopModel.phoneNumber),
                      pw.Text("GST No. xxxxxxxxx"),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 48),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Billed To"),
                      pw.Text(customerName),
                      pw.Text(customerPhone),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Invoice Number"),
                      pw.Text("xxxxxx"),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Date of Issue"),
                      pw.Text(DateFormat().format(DateTime.now())),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text(
                "Dear Customer, thanks for buying at ${shopModel.shopName}, feel free to see the list of items below.",
                textAlign: pw.TextAlign.start,
              ),
              pw.SizedBox(height: 24),
              itemColumn(elements),
              pw.SizedBox(height: 24),
              pw.Text(
                "Thanks for your trust, and till the next time.",
                textAlign: pw.TextAlign.start,
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                "Kind regards,",
                textAlign: pw.TextAlign.start,
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                shopModel.sellerName,
                textAlign: pw.TextAlign.start,
              )
            ],
          );
        },
      ),
    );

    Uint8List byteList = await pdf.save();
    return byteList;
  }

  pw.Expanded itemColumn(List<CustomRow> elements) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          for (var element in elements)
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Text(element.name, textAlign: pw.TextAlign.left)),
                pw.Expanded(
                    child: pw.Text(element.quantity,
                        textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child: pw.Text(element.unitPrice,
                        textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child: pw.Text(element.totalPrice,
                        textAlign: pw.TextAlign.right)),
              ],
            )
        ],
      ),
    );
  }

  Future<String> savePdfFile({
    required String fileName,
    required Uint8List byteList,
  }) async {
    final output = await getTemporaryDirectory();
    final filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);

    await file.writeAsBytes(byteList);

    return filePath;
  }

  String getSubTotal(List<ProductModel> products) {
    double total = 0.0;
    for (int i = 0; i < products.length; i++) {
      total += products[i].unit_price * products[i].quantity;
    }
    return total.toStringAsFixed(2);
  }
}
