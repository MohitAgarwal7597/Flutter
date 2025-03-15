import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000"; // Adjust if needed

  static Future<bool> sendOtp(String email) async {
    final Uri url = Uri.parse("$baseUrl/send-otp");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}), // Sends entered email
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
