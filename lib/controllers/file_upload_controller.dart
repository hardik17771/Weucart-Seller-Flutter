import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:weu_cart_seller/core/constants.dart';
import 'package:weu_cart_seller/core/utils.dart';

class FileUploadController {
  Future<Map<String, dynamic>?> uploadProductImage({
    required BuildContext context,
    required File file,
  }) async {
    Map<String, dynamic>? imageData;
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConstants.backendUrl}/upload/blob-upload"),
      );

      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: DateTime.now().toIso8601String(),
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      var jsonData = json.decode(response.body);
      var message = jsonData["message"];

      if (response.statusCode == 200) {
        var dataMap = jsonData['data'];

        imageData = dataMap;
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Internal Server Error",
          message: message,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Internal Server Error",
        message: e.toString(),
      );
    }

    return imageData;
  }
}
