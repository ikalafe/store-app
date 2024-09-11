import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  // Constructor initializing with defult User object
  // Purpose: Manage the state of the user object allowing updates
  UserProvider()
      : super(User(
            id: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            password: '',
            token: ''));
  // Getter method to extract value from an object
  User? get user => state;

  // Method to set user state from json
  // Purpose: Updates the user state base on json String representation of User Object
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  // Make the data accisible within the application
  final userProvider = StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
}
