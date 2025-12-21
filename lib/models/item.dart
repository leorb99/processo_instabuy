import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  String? id;
  DateTime createdAt;
  String? itemType;
  String? erpInternalCode;
  List<String?> subcategoryIds;
  String? mainSubcategory;
  String? storeId;
  bool visible;
  bool blockSale;
  String? description;
  List<String> images;
  String name;
  String? nameOnErp;
  List<CustomInfo> customInfos;
  List<Price> prices;
  double minPriceValid;
  StockInfos stockInfos;
  List<dynamic> variationItems;
  List<dynamic> relatedItems;
  String? slug;
  String? brand;
  String? unitType;
  double incrementValue;
  Shipping shipping;
  bool availableStock;

  Item({
    required this.id,
    required this.createdAt,
    required this.itemType,
    required this.erpInternalCode,
    required this.subcategoryIds,
    required this.mainSubcategory,
    required this.storeId,
    required this.visible,
    required this.blockSale,
    required this.description,
    required this.images,
    required this.name,
    required this.nameOnErp,
    required this.customInfos,
    required this.prices,
    required this.minPriceValid,
    required this.stockInfos,
    required this.variationItems,
    required this.relatedItems,
    required this.slug,
    required this.brand,
    required this.unitType,
    required this.incrementValue,
    required this.shipping,
    required this.availableStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    itemType: json["item_type"],
    erpInternalCode: json["erp_internal_code"],
    subcategoryIds: List<String>.from(json["subcategory_ids"].map((x) => x)),
    mainSubcategory: json["main_subcategory"],
    storeId: json["store_id"],
    visible: json["visible"],
    blockSale: json["block_sale"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    name: json["name"],
    nameOnErp: json["name_on_erp"],
    customInfos: List<CustomInfo>.from(json["custom_infos"].map((x) => CustomInfo.fromJson(x))),
    prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
    minPriceValid: json["min_price_valid"]?.toDouble(),
    stockInfos: StockInfos.fromJson(json["stock_infos"]),
    variationItems: List<dynamic>.from(json["variation_items"].map((x) => x)),
    relatedItems: List<dynamic>.from(json["related_items"].map((x) => x)),
    slug: json["slug"],
    brand: json["brand"],
    unitType: json["unit_type"],
    incrementValue: json["increment_value"],
    shipping: Shipping.fromJson(json["shipping"]),
    availableStock: json["available_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "item_type": itemType,
    "erp_internal_code": erpInternalCode,
    "subcategory_ids": List<dynamic>.from(subcategoryIds.map((x) => x)),
    "main_subcategory": mainSubcategory,
    "store_id": storeId,
    "visible": visible,
    "block_sale": blockSale,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "name": name,
    "name_on_erp": nameOnErp,
    "custom_infos": List<dynamic>.from(customInfos.map((x) => x.toJson())),
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "min_price_valid": minPriceValid,
    "stock_infos": stockInfos.toJson(),
    "variation_items": List<dynamic>.from(variationItems.map((x) => x)),
    "related_items": List<dynamic>.from(relatedItems.map((x) => x)),
    "slug": slug,
    "brand": brand,
    "unit_type": unitType,
    "increment_value": incrementValue,
    "shipping": shipping.toJson(),
    "available_stock": availableStock,
  };
}

class CustomInfo {
  String? field;
  String? value;

  CustomInfo({
    required this.field,
    required this.value,
  });

  factory CustomInfo.fromJson(Map<String, dynamic> json) => CustomInfo(
    field: json["field"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "value": value,
  };
}

class Price {
  String? id;
  String? title;
  String? internalCode;
  double? price;
  double? promoPrice;
  List<dynamic> barCodes;
  double? qtdStock;

  Price({
    required this.id,
    required this.title,
    required this.internalCode,
    required this.price,
    this.promoPrice,
    required this.barCodes,
    required this.qtdStock,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    id: json["id"],
    title: json["title"],
    internalCode: json["internal_code"],
    price: json["price"]?.toDouble(),
    promoPrice: json["promo_price"]?.toDouble(),
    barCodes: List<dynamic>.from(json["bar_codes"].map((x) => x)),
    qtdStock: json["qtd_stock"]?.toDouble(),
  );
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "internal_code": internalCode,
    "price": price,
    "promo_price": promoPrice,
    "bar_codes": List<dynamic>.from(barCodes.map((x) => x)),
    "qtd_stock": qtdStock,
  };
}

class Shipping {
  bool deliverable;

  Shipping({
    required this.deliverable,
  });
  
  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    deliverable: json["deliverable"],
  );

  Map<String, dynamic> toJson() => {
    "deliverable": deliverable,
  };
}

class StockInfos {
  double? stockBalance;
  bool shouldBlockOnStockHole;
  DateTime? blockDate;

  StockInfos({
    required this.stockBalance,
    required this.shouldBlockOnStockHole,
    required this.blockDate
  });
  
  factory StockInfos.fromJson(Map<String, dynamic> json) => StockInfos(
    stockBalance: json["stock_balance"]?.toDouble(),
    shouldBlockOnStockHole: json["should_block_on_stock_hole"],
    blockDate: json["block_date"] == null ? null : DateTime.parse(json["block_date"]),
  );
  
  Map<String, dynamic> toJson() => {
    "stock_balance": stockBalance,
    "should_block_on_stock_hole": shouldBlockOnStockHole,
    "block_date": blockDate?.toIso8601String(),
  };
}
