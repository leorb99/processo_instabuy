import 'dart:convert';
import 'package:flutter_application_instabuy/models/banners.dart' as banners;
import 'package:flutter_application_instabuy/models/products.dart' as products;
import 'package:flutter_application_instabuy/models/promos.dart' as promos;
import 'package:http/http.dart' as http;

var responseJson;

class Api {
  Future<void> fetchData() async {
    var uri = Uri.parse('https://api.instabuy.com.br/apiv3/layout')
      .replace(queryParameters: {'subdomain': 'bigboxdelivery'});
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print('Requisição bem sucedida!');
      responseJson = json.decode(const Utf8Decoder().convert(response.bodyBytes));
    } else {
      throw Exception('Erro na requisição da API!');  
    }
  } 
}

class BannerApi {
  Future<List<banners.Welcome?>> getAllBanners() async {
    final banner = json.encode(responseJson['data']['banners']);
    return banners.welcomeBannersFromJson(banner);
  }
}

class PromoApi {
  Future<List<promos.Welcome?>> getAllPromos() async {
    final promo = json.encode(responseJson['data']['promo']);
    return promos.welcomePromosFromJson(promo);
  }
}

class ProductsApi {
  Future<List<products.Welcome?>> getAllProducts() async {
    final prods = json.encode(responseJson['data']['collection_items']);
    return products.welcomeProductsFromJson(prods);
  }
}
