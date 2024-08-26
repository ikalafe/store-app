import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/services/manage_http_response.dart';

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
          showSnackBar(context, 'Account has been Created for you');
        });
  } catch (e) {}
}
