import 'package:flutter_application_instabuy/models/collection_items.dart';
import 'package:flutter_application_instabuy/models/item.dart';

class ProductsService {
  Map<String,String> fetchCategories(List<CollectionItem?> allProducts) {
    Map<String,String> categories = {};
    for (var product in allProducts) {
      if (product != null && product.title != null) {
        categories[product.id!] = product.title!;
      }
    }
    return categories;
  }

  List<Item> fetchProductsByCategory(List<CollectionItem> allProducts, String category) {
    List<Item> items = [];
    for (var product in allProducts) {
      if (product.id == category) {
        items.addAll(product.items);
      }
    }
    return items;
  }
}
