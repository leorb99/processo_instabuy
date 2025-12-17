import 'dart:convert';
import 'package:flutter_application_instabuy/models/banners.dart' as banners;
import 'package:flutter_application_instabuy/models/products.dart' as products;
import 'package:flutter_application_instabuy/models/promos.dart' as promos;
import 'package:http/http.dart' as http;

class BannerApi {
  Future<List<banners.Welcome?>> getAllBanners() async {
    var uri = Uri.parse('https://api.instabuy.com.br/apiv3/layout')
      .replace(queryParameters: {'subdomain': 'bigboxdelivery'});
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseJson = json.decode(const Utf8Decoder().convert(response.bodyBytes)); 
      final bnrs = json.encode(responseJson['data']['banners']);
      return banners.welcomeBannersFromJson(bnrs);
    }
    return Future.error('Erro na requisição dos banners!');
  }
}

class PromoApi {
  Future<List<promos.Welcome?>> getAllPromos() async {
    var uri = Uri.parse('https://api.instabuy.com.br/apiv3/layout')
      .replace(queryParameters: {'subdomain': 'bigboxdelivery'});
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseJson = json.decode(const Utf8Decoder().convert(response.bodyBytes)); 
      final promo = json.encode(responseJson['data']['promo']);
      return promos.welcomePromosFromJson(promo);
    }
    return Future.error('Erro na requisição das promos!');
  }
}

class ProductsApi {
  Future<List<products.Welcome?>> getAllProducts() async {
    var uri = Uri.parse('https://api.instabuy.com.br/apiv3/layout')
      .replace(queryParameters: {'subdomain': 'bigboxdelivery'});
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseJson = json.decode(const Utf8Decoder().convert(response.bodyBytes)); 
      final prods = json.encode(responseJson['data']['collection_items']);
      return products.welcomeProductsFromJson(prods);
    }
    return Future.error('Erro na requisição dos produtos!');
  }
}
