import 'package:flutter/material.dart';
import 'package:flutter_application_instabuy/models/banners.dart' as banners;
import 'package:flutter_application_instabuy/models/collection_items.dart';
import 'package:flutter_application_instabuy/models/promos.dart';
import 'package:flutter_application_instabuy/services/api_service.dart';
import 'package:flutter_application_instabuy/services/collection_items_service.dart';
import 'package:flutter_application_instabuy/services/banners_service.dart';
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

  Future<List<String>> fetchMobileBanners() async {
    final bannersService = BannersService();
    return await bannersService.fetchMobileBanners();
  }

  Drawer menuDrawer() {
    return Drawer(
      backgroundColor: Colors.deepPurple[200],
      child: Column(  
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categorias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),    
            ),
          ),
          Expanded(
            child: MenuItems(
              categoriesFuture: fetchCategories(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: menuDrawer(),
      body: Column(
        children: [
          carouselBanner(),
          Container(
            height: 240,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.red,

            ),
          )
        ],
      ),

    );
  }

  FutureBuilder<List<String>> carouselBanner() {
    return FutureBuilder<List<String>>(
      future: fetchMobileBanners(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 170,
            width: double.infinity,
            child: PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final url = snapshot.data![index];
                return CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.contain,
                );
              },
            ),
          );
        } else {
          return Text('Falha ao carregar os banners');
        }
      },
    );
  }

}

AppBar appBar(BuildContext context) {
  return AppBar(
    title: Text('Desafio Instabuy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[200])),
    centerTitle: true,
    backgroundColor: Color(0xFF663399),
  );
}
