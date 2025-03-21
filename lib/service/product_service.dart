import 'dart:convert';
import 'package:app/models/products.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String apiUrl = 'https://fakestoreapi.in/api/products';

  // Method to fetch products
  Future<List<Products>> fetchProducts() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData); // Print API response
    List<dynamic> productList = jsonData['products'];
    return productList.map((product) => Products.fromJson(product)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

}
