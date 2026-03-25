import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var url = Uri.parse(
      "http://gminnovex.com:3000/api/v1/Product?page_no=3&limit=20",
    );

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    var data = jsonDecode(response.body);

    if (data["status"] == true) {
      List list = data["data"];

      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed");
    }
  }
}
