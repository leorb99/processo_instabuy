import 'dart:convert';

List<Banner> bannerFromJson(String str) => List<Banner>.from(json.decode(str).map((x) => Banner.fromJson(x)));

String bannerToJson(List<Banner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banner {
  String? id;
  String? image;
  String? title;
  bool isMobile;
  bool isDesktop;
  bool isMini;
  Link link;
  String? href;

  Banner({
    required this.id,
    required this.image,
    required this.title,
    required this.isMobile,
    required this.isDesktop,
    required this.isMini,
    required this.link,
    required this.href,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
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
