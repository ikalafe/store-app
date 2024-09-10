import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  // Get all categories
  Future<List<CategoryModel>> loadCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      debugPrint('دسته بندی ها: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<CategoryModel> categories =
            data.map((category) => CategoryModel.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception('متاسفانه موفق به دریافت دسته بندی ها نشدیم... ):');
      }
    } catch (e) {
      debugPrint('e');
      throw Exception(
          'خطایی در دیافت اطلاعات دسته بندی ها به وجود آمد... ): $e');
    }
  }
}
