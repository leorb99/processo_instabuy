import 'package:flutter_application_instabuy/models/collection_items.dart';
import 'package:flutter_application_instabuy/services/api_service.dart';
import 'package:flutter_application_instabuy/models/item.dart';

class ProductsService {
  Future<Map<String,String>> fetchCategories(List<CollectionItem?> allProducts) async {
    Map<String,String> categories = {};
    for (var product in allProducts) {
      if (product != null && product.title != null) {
        categories[product.id!] = product.title!;
      }
    }
    return categories;
  }

  Future<List<Item>> fetchProductsByCategory(List<CollectionItem> allProducts, String category) async {
    List<Item> items = [];
    for (var product in allProducts) {
      if (product.id == category) {
        items.addAll(product.items);
      }
    }
    return items;
  }
}

void main() async {
  Api api = Api();
  await api.fetchData();
  ProductsApi productsApi = ProductsApi();
  List<CollectionItem?> all = await productsApi.getAllCollectionItems();
  ProductsService productsService = ProductsService();
  print(await productsService.fetchCategories(all));

  List<Item> itens = await productsService.fetchProductsByCategory(all.whereType<CollectionItem>().toList(), '5ad627e494e429505d78d67d');
  for (var product in itens) {
        print(product.name);
        print(product.prices.single.id); // exemplo - field not defined in Welcome model
      }
}
