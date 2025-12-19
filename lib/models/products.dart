import 'package:flutter_application_instabuy/models/item.dart';
import 'dart:convert';

List<Welcome> welcomeProductsFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeProductsToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String? id;
  String? title;
  String? slug;
  List<Item> items;

  Welcome({
    required this.id,
    required this.title,
    required this.slug,
    required this.items,
  });
  
  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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

