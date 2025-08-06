import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://www.360property.in'; 
  
  static Future<bool> isUserRegistered(String mobile) async {
    final url = Uri.parse('$baseUrl/api/check-user');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': mobile}),
      );

      
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final data = jsonDecode(response.body);
      return data['isRegistered'] == true;
    } else {
      print('Unexpected response: ${response.statusCode}, body: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error checking user registration: $e');
    return false;
  }
}
  static Future<String?> sendOtp(String mobile, String countryCode) async {
    final url = Uri.parse('$baseUrl/api/send-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'mobile': mobile,
        'countryCode': countryCode,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      return data['token']; // Save for verify step
    } else {
      return null;
    }
  }

  // 2. Verify OTP
  static Future<bool> verifyOtp(String otp, String token) async {
    final url = Uri.parse('$baseUrl/api/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'otp': otp,
        'token': token,
      }),
    );

    final data = jsonDecode(response.body);

    return response.statusCode == 200 && data['success'] == true;
  }
}
