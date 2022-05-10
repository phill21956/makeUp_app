import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:makeup_shop_app/models/brand_model.dart';
import '../models/product_model.dart';

class ApiService {
  static var client = http.Client();
  // String productURL =
  //     "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline";

  static Future<List<ProductModel>> fetchProducts() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      throw "Unable to retrieve stocks.";
    }
  }

   static Future<List<BrandModel>> fetchBrands() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return brandModelFromJson(jsonString);
    } else {
      throw "Unable to retrieve stocks.";
    }
  }

    static Future<List<ProductModel>> getUserSuggestions(String? query) async {
    final url = Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => ProductModel.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query!.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
