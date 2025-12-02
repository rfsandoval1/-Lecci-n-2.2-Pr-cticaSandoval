import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class FakeStoreDataSource {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchAllProducts() async {
    final url = Uri.parse(baseUrl);
    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception('Error fetching products');
    }

    final data = jsonDecode(resp.body) as List;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
