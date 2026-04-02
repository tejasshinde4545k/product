import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = "token";
  static const String _baseUrl = "http://gminnovex.com:3000/api/v1";

  Future<Map<String, dynamic>> login({
    required String mobileNo,
    required int loginPin,
  }) async {
    final url = Uri.parse("$_baseUrl/User/Login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile_no": mobileNo, "login_pin": loginPin}),
    );

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
