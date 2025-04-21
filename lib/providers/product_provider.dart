import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/product_service.dart';

final productServiceProvider = Provider((_) => ProductService());

final productListProvider = FutureProvider<List<Product>>((ref) {
  final service = ref.watch(productServiceProvider);
  return service.fetchProducts();
});

final productCreationProvider = StateProvider<String?>((_) => null);
