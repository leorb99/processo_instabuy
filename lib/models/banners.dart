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
void main() {
  const jsonString = '''
[{"id":"692dfb99815e8589669ee7ee","image":"a5db1c129d4c4fe6b8f61ca5a5f82cb0.jpeg","title":"HoHoHo 🎅","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"category_id":"692ddb65bb65fd32fccd8ae7"},"href":""},{"id":"692dfbcc815e8589669eeab5","image":"e292b90768f84435a66a50bc62ec11e0.png","title":"Hohoho 🎅","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"category_id":"692ddb65bb65fd32fccd8ae7"},"href":""},{"id":"6764892cd15ebc9b4f4afe77","image":"a55aafd347a9441bacf7f53c2b788652.png","title":"Banner mobile","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"external":"https://meubigbox.com.br/v1/apps/cadastroPrimeiraFase"},"href":""},{"id":"6764889cd15ebc9b4f4afbcd","image":"2d61e37b72fa447d90e145c1699a6277.png","title":"Banner Oficial","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"external":"https://meubigbox.com.br/v1/apps/cadastroPrimeiraFase"},"href":""},{"id":"691b25911672224b19a0068b","image":"121c966267f24a80965d5b5cd4cc8674.jpeg","title":"Seu Natal pede Sadia - 17.11","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"aggregation_id":"691b1d0bf4754cba4241618e"},"href":""},{"id":"691b268de1625d258a63deaf","image":"085e5527528e473db2aeae988d393e0a.png","title":"Seu Natal pede Sadia - 17.11.2025","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"aggregation_id":"691b1d0bf4754cba4241618e"},"href":""},{"id":"6925da018c3f1dd8a72b3697","image":"837c10d597a94874bf66dd87ce9b23bd.jpeg","title":"Seara Stranger Things","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"aggregation_id":"6925d9a43f0c0b81b8979f9d"},"href":""},{"id":"6925db0c0540d0df60fa2ffe","image":"13a5cb879e414272971ef8299b02185d.png","title":"Seara Fiesta","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"product_id":"63b328ec65481037c45bcea3"},"href":""},{"id":"69299bbb557216273f6d94e2","image":"cd47b9aca278471f89afd43679507c12.png","title":"Seara Fiesta.","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"product_id":"63b328ec65481037c45bcea3"},"href":""},{"id":"69299c3e557216273f6d9f56","image":"286b214e68cc4729870d7b29edc28eee.png","title":"Seara Stranger Things.","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"aggregation_id":"6925d9a43f0c0b81b8979f9d"},"href":""},{"id":"68fb7cb75639e82c729ba733","image":"d99b34f9dcd44da49af96912c1fb053c.png","title":"Becel - Outubro","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"aggregation_id":"68fb7c565639e82c729b9fbf"},"href":""},{"id":"68ff83f64abb8926ffe657d9","image":"ece11e466b07418c800efc5246ff49d0.jpeg","title":"Becel - Outubro/25","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"aggregation_id":"68fb7c565639e82c729b9fbf"},"href":""},{"id":"691b26dafac37715fa550e27","image":"19fdb580f00b42dfbf7c446ef6f2a5a8.jpeg","title":"Só Perdigão tem CHESTER! - 17.11","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"aggregation_id":"691b1f6ace7c828ab0e3bfed"},"href":""},{"id":"691b3a081672224b19a10535","image":"c11edda8d8994acdbf45099f481cfd03.png","title":"Só Perdigão tem CHESTER! - 17.11.2025","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"aggregation_id":"691b1f6ace7c828ab0e3bfed"},"href":""},{"id":"69282b784d703ea6167d7f78","image":"8b50d8a316444eb3a6bfc3f47fc47b81.png","title":"Clube do Vinho BIG BOX 🍷","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"category_id":"5eeab546973278ec07b127ab"},"href":""},{"id":"69282bd4d214cacd5b7169c9","image":"e7c3e859ca8a410c94a75c9031fd6249.png","title":"Clube do Vinho BIG BOX","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"category_id":"5eeab546973278ec07b127ab"},"href":""},{"id":"691239c972724c05b31e06b4","image":"7360420097614d19b465cd1ad0df7771.png","title":"Bio Force - 10.11","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"aggregation_id":"691238096223813600652c66"},"href":""},{"id":"69123a0562238136006552e8","image":"899f6d31151b42ec9983236fb7e9bf6e.png","title":"Bio Force - 10.11.25","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"aggregation_id":"691238096223813600652c66"},"href":""},{"id":"679235e6a146f5f6ee2d147b","image":"4ee10f9f29c24b8c859d7bc71302ce20.png","title":"Banner entrega pc","is_mobile":false,"is_desktop":true,"is_mini":false,"link":{"offers":true},"href":""},{"id":"67923788a146f5f6ee2d1ec6","image":"c22c7f64ad08479caa9c58e85d317309.png","title":"Banner entrega mobile","is_mobile":true,"is_desktop":false,"is_mini":false,"link":{"offers":true},"href":""},{"id":"67648738b02966b6a16511b1","image":"81442c524cde44bb84709b040f176305.png","title":"Mini banner","is_mobile":false,"is_desktop":false,"is_mini":true,"link":{"offers":true},"href":""}]
''';
  final List<Welcome> welcome = welcomeBannersFromJson(jsonString.replaceAll('\\"', "'"));

  print(welcome[0].id);        // Banner Teste
  // print(welcome.data.banners[0].link.categoryId); // 123

  // Converter de volta para JSON
  // final jsonBack = welcomeBannersToJson(welcome);
  // print(jsonBack);
}
