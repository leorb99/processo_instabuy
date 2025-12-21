import 'dart:convert';
import 'package:flutter_application_instabuy/models/banners.dart';
import 'package:flutter_application_instabuy/models/collection_items.dart';
import 'package:flutter_application_instabuy/models/promos.dart';
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
  Future<List<Banner?>> getAllBanners() async {
    final banner = json.encode(responseJson['data']['banners']);
    return bannerFromJson(banner);
  }
}

class PromoApi {
  Future<List<Promo?>> getAllPromos() async {
    final promo = json.encode(responseJson['data']['promo']);
    return promoFromJson(promo);
  }
}

class ProductsApi {
  Future<List<CollectionItem?>> getAllCollectionItems() async {
    final prods = json.encode(responseJson['data']['collection_items']);
    return collectionItemFromJson(prods);
  }
}
