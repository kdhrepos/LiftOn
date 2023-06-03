import 'package:dio/dio.dart';

const server = "http://localhost:8080";
final Dio dio = Dio();

bool isValidEmail(String email) {
  // Regular expression pattern for email validation
  const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

  // Create a RegExp object
  final regex = RegExp(pattern);

  // Use the hasMatch method to check if the email matches the pattern
  return regex.hasMatch(email);
}

bool isPasswordSame(String password, String confirm) {
  if (password == confirm) return true;
  return false;
}

bool checkPasswordLength(String password) {
  if (password.length < 5) return false;
  return true;
}

bool isFieldsEmpty(List<String> fields) {
  for (String s in fields) {
    if (s.isEmpty) {
      return true;
    }
  }
  return false;
}
