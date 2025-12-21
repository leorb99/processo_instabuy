import 'dart:convert';
import 'package:flutter_application_instabuy/models/banners.dart';
import 'package:flutter_application_instabuy/models/collection_items.dart';
import 'package:flutter_application_instabuy/models/item.dart';
import 'dart:io';
// import 'package:http/http.dart' as http;

var responseJson;


class Api {
  Future<void> fetchData() async {
    final uri = Uri.parse('https://api.instabuy.com.br/apiv3/layout')
        .replace(queryParameters: {'subdomain': 'bigboxdelivery'});
    final client = HttpClient();

    try {
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        print('Requisição bem sucedida!');
        final responseBody =
            await response.transform(utf8.decoder).join();
        responseJson = json.decode(responseBody);
      } else {
        throw Exception(
          'Erro na requisição da API! Status: ${response.statusCode}',
        );
      }
    } finally {
      client.close();
    }
  }
}


class BannerApi {
  List<Banner> getAllBanners() {
    final banner = json.encode(responseJson['data']['banners']);
    return bannerFromJson(banner);
  }
}

class PromoApi {
  List<Item> getAllPromos() {
    final promo = json.encode(responseJson['data']['promo']);
    return itemFromJson(promo);
  }
}

class ProductsApi {
  List<CollectionItem> getAllCollectionItems() {
    final prods = json.encode(responseJson['data']['collection_items']);
    return collectionItemFromJson(prods);
  }
}
