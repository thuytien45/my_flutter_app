import 'package:dio/dio.dart';

import '../core/api_client.dart';
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await dio.get('/');
    print('Full response: ${response.data}');

    final resultData = response.data['data']?['result'] as List?;
    return resultData?.map((json) => Product.fromJson(json)).toList() ?? [];
  }

  Future<String?> createProduct(Product product) async {
    try {
      await dio.post('/', data: product.toJson());
      return null;
    } on DioException catch (e) {
      return e.response?.data['error'].toString() ?? 'Unknown error';
    }
  }
}
