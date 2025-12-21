import 'package:flutter_application_instabuy/models/item.dart';
import 'dart:convert';

List<CollectionItem> collectionItemFromJson(String str) => List<CollectionItem>.from(json.decode(str).map((x) => CollectionItem.fromJson(x)));

String collectionItemToJson(List<CollectionItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollectionItem {
  String? id;
  String? title;
  String? slug;
  List<Item> items;

  CollectionItem({
    required this.id,
    required this.title,
    required this.slug,
    required this.items,
  });
  
  factory CollectionItem.fromJson(Map<String, dynamic> json) => CollectionItem(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

