import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
  });

  //Serialization: Convert User object to a map
  //Map: A Map is a collection of key-value pairs
  //Why: Converting to a map is an intermediate step that makes it easier to serialize
  //the object to formates like json for storage or transmission.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password
    };
  }

  //Serialization: Convert Map to a Json String
  //This method directly encodes the data from the Map into a Json String

  //The json.encode() function converts a Dart object (such as Map or List)
  //into a Json String representation, making it suitable for communication
  //between different systems.
  String toJson() => json.encode(toMap());

  //Deserialization: Convert a Map to a User Object
  //purpose - Manipulation an user: Once the data is converted a to a User Object
  //it can be easily manipuated and use within the application. For example
  //we might want to display the user's fullName, email etc on the Ui.

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      password: map['password'] as String? ?? '',
    );
  }
}
