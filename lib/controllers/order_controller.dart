import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/services/manage_http_response.dart';

class OrderController {
  // Function to Upload orders
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required context,
  }) async {
    try {
      final OrderModel order = OrderModel(
        id: id,
        fullName: fullName,
        email: email,
        state: state,
        city: city,
        locality: locality,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        processing: processing,
        delivered: delivered,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/orders'),
        body: order.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'سفارش شما با موفقیت ثبت شد',
            background: Colors.green,
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        'مشکلی در ثبت سفارش پیش آمد',
        background: Colors.red.shade700,
      );
      debugPrint('***** خطایی در ثبت سفارش رخ داد : $e *****');
    }
  }

  // Method to GET orders by buyerId
  Future<List<OrderModel>> loadOrders({required String buyerId}) async {
    try {
      // Send an HTTP GET request to get the orders by the buyerId
      final http.Response response = await http.get(
        Uri.parse('$uri/api/orders/$buyerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      // Check if the response status code is 200.
      if (response.statusCode == 200) {
        // Parse the Json response body into dynamic List
        // This convers the json data into a format that can be further processed in Dart.
        List<dynamic> data = jsonDecode(response.body);
        // Map the dynamic list to list of OrderModel object using the from json factory method
        //This step convert the raw data into list of the orders instanse, witch are easier to work with
        List<OrderModel> orders =
            data.map((order) => OrderModel.fromJson(order)).toList();
        return orders;
      } else {
        // Throw an exception if the server responded with an error status code
        throw Exception('Faild to load Orders');
      }
    } catch (e) {
      throw Exception('Errorr loading orders');
    }
  }

  // Delete order by ID
  Future<void> deleteOrder({required String id, required context}) async {
    try {
      // Send an HTTP request to delete the order by _id
      http.Response response = await http.delete(
        Uri.parse('$uri/api/orders/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      // Handle the http Response
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'سفارش با موفقیت حذف شد');
        },
      );
    } catch (e) {
      showSnackBar(context, 'مشکلی در حذف سفارش رخ داد');
      debugPrint('***** مشکل در حذف سفارش: $e *****');
    }
  }
}
