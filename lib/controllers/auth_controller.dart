import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user
              .toJson(), // Convert the user Object to Json for the request body
          headers: <String, String>{
            // Set the Headers for the request
            'Content-Type':
                'application/json; charset=UTF-8', // Specify the context type as Json
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
            showSnackBar(context, 'Account has been Created for you',
                background: Colors.green);
          });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // Sign In users function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode(
          {
            'email': email, // Include the email in the request body
            'password': password, // Include the password in the request body
          },
        ),
        headers: <String, String>{
          // The will set the header
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Handle the respose using the manage http response
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
          showSnackBar(context, 'Logged In Successfully',
              background: Colors.green);
        },
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
