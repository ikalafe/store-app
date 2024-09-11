import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/subcategory_model.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  Future<List<SubcategoryModel>> getSubcategoriesByCategoryName(
      String categoryName) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/category/$categoryName/subcategories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data
              .map((subcategory) => SubcategoryModel.fromJson(subcategory))
              .toList();
        } else {
          debugPrint('subcategory not found');
          return [];
        }
      } else if (response.statusCode == 404) {
        debugPrint('subcategories not found');
        return [];
      } else {
        debugPrint('failed to fetch subcategorieds');
        return [];
      }
    } catch (e) {
      debugPrint('error fetching subcategories: $e');
      return [];
    }
  }
}
