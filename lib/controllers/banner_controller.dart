import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/banner_model.dart';
import 'package:http/http.dart' as http;

class BannerController {
  // Fetch Banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      // Send an http GET request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      debugPrint('banners: ${response.body}');

      if (response.statusCode == 200) {
        //OK
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        // Throw an exception if the server response with an error status code
        throw Exception('مشکلی در بارگزاری بنر ها به وجود آمد ):');
      }
    } catch (e) {
      throw Exception('Error loading Banners');
    }
  }
}
