import 'package:flutter/material.dart';
import 'package:flutter_application_instabuy/models/banners.dart' as banners;
import 'package:flutter_application_instabuy/models/collection_items.dart';
import 'package:flutter_application_instabuy/models/promos.dart';
import 'package:flutter_application_instabuy/services/api_service.dart';
import 'package:flutter_application_instabuy/services/collection_items_service.dart';
import 'package:popover/popover.dart';
import 'menu_items.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {
  List<banners.Banner>? allBanners;
  List<Promo>? allPromos;
  List<CollectionItem>? allProducts;
  bool isBannersLoaded = false;
  bool isPromosLoaded = false;
  bool isProductsLoaded = false;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    load();
    // TODO: carregar a lista de categorias e as imagens dos banners e promo
  }
  Future<void> load() async {
    try {
      final apiService = Api();
      await apiService.fetchData();
      
      final bannerApi = BannerApi();
      final promoApi = PromoApi();
      final productsApi = ProductsApi();

      final results = await Future.wait([
        bannerApi.getAllBanners(),
        promoApi.getAllPromos(),
        productsApi.getAllCollectionItems(),
      ]);

      setState(() {
        allBanners = results[0].cast<banners.Banner>();
        allPromos = results[1].cast<Promo>();
        allProducts = results[2].cast<CollectionItem>();
        isLoaded = true;
        isBannersLoaded = true;
        isPromosLoaded = true;
        isProductsLoaded = true;
      });
    } catch (e) {
      print("Erro geral no load: $e");
    }
  }

  Future<Map<String, String>> fetchCategories() async {
    final productsService = ProductsService();
    return await productsService.fetchCategories(allProducts?.whereType<CollectionItem>().toList() ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
            SizedBox(height: 15),
            Center(
              child: Text(
                'Bem-vindo ao Desafio Instabuy!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: 'https://ibassets.com.br/ib.store.banner/bnr-a5db1c129d4c4fe6b8f61ca5a5f82cb0.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            
            ],
          ),
        );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    title: Text('Desafio Instabuy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[200])),
    centerTitle: true,
    backgroundColor: Color(0xFF663399),
    leading: GestureDetector(
      onTap: () => showPopover(context: context, bodyBuilder: (context) => MenuItems(),
        direction: PopoverDirection.right,
        width: 150,
        height: 100,
        arrowHeight: 15,
        arrowWidth: 30,
      )
        // Ação ao tocar no ícone de menu
      ,
      child: 
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Color(0xFF663399),
        ),
        alignment: Alignment.center,
        child: Icon(  
          Icons.menu,
          color: Colors.grey[200],
        ),
      )
    )
  );
}
