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

  // Method to clear user state
  void signOut() {
    state = null;
  }

  // Method to Recreate the user state
  void recreateUserState({
    required String state,
    required String city,
    required String locality,
  }) async {
    if (this.state != null) {
      this.state = User(
        id: this.state!.id, // Preserve the existing user id
        fullName: this.state!.fullName, // Preserve the existing user fullname
        email: this.state!.email, // Preserve the existing user email
        state: state,
        city: city,
        locality: locality,
        password: this.state!.password, // Preserve the existing user password
        token: this.state!.token, // Preserve the existing user token
      );
    }
  }
}

// Make the data accisible within the application
final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
