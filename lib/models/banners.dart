import 'dart:convert';

List<Welcome> welcomeBannersFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeBannersToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String? id;
  String? image;
  String? title;
  bool isMobile;
  bool isDesktop;
  bool isMini;
  Link link;
  String? href;

  Welcome({
    required this.id,
    required this.image,
    required this.title,
    required this.isMobile,
    required this.isDesktop,
    required this.isMini,
    required this.link,
    required this.href,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    isMobile: json["is_mobile"],
    isDesktop: json["is_desktop"],
    isMini: json["is_mini"],
    link: Link.fromJson(json["link"]),
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "is_mobile": isMobile,
    "is_desktop": isDesktop,
    "is_mini": isMini,
    "link": link.toJson(),
    "href": href,
  };
}

class Link {
  String? categoryId;

  Link({
    required this.categoryId,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
  };
}
