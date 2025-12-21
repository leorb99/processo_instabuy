import 'package:flutter_application_instabuy/models/item.dart';

class ItemsService {
  Map<String, List<String>> fetchItemImage(Item item, String size, String prefix) {
    Map<String, List<String>> itemImages = {};
    List<String> imgs = [];
    try {
      for(var img in item.images) {
        imgs.add('https://ibassets.com.br/ib.item.image.$size/$prefix-$img');
            }
          itemImages[item.id!] = imgs;
      return itemImages;
    } catch (e) {
      print("Erro ao buscar imagem dos itens: $e");
      return {};
    }
  }
}