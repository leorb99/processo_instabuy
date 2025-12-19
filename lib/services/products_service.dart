import 'api_service.dart';
import 'package:flutter_application_instabuy/models/products.dart' as products;

class ProductsService {
  final ProductsApi _productsApi = ProductsApi();

  Future<List<String>> listCategories() async {
    List<products.Welcome?> allProducts = await _productsApi.getAllProducts();
    Set<String> categories = {};
    for (var product in allProducts) {
      if (product != null && product.title != null) {
        categories.add(product.title!);
      }
    }
    return categories.toList();
  }
}