import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController {
  // Define a function that returns a future containing list of the product model objects
  Future<List<ProductModel>> loadPopularProducts() async {
    // Use a try block to handle any exceptions that might occur in the http request proccess
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/popular-products'),
        // Set the http headers for the request,
        // Specify that the content type is json with the UTF-8 encoding
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      debugPrint(response.body);
      // Check if the HTTP response status code is 200
      // Which means the request was successfull
      if (response.statusCode == 200) {
        // Decode the json response body into list of dynamic object
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        // Map each items in the list to product model object which we can use
        List<ProductModel> products = data
            .map(
              (product) =>
                  ProductModel.fromMap(product as Map<String, dynamic>),
            )
            .toList();
        return products;
      } else {
        // If status code is not 200, throw an exception
        // indicating failure to load the popular products
        throw Exception('Faild to load products');
      }
    } catch (e) {
      throw Exception('Error Loading Product: $e');
    }
  }

  // Load Product by category function
  Future<List<ProductModel>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        // Decode the json response body into list of dynamic object
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        // Map each items in the list to product model object which we can use
        List<ProductModel> products = data
            .map(
              (product) =>
                  ProductModel.fromMap(product as Map<String, dynamic>),
            )
            .toList();
        return products;
      } else {
        // If status code is not 200, throw an exception
        // indicating failure to load the popular products
        throw Exception('Faild to load products');
      }
    } catch (e) {
       throw Exception('Error Loading Product: $e');
    }
  }
}
