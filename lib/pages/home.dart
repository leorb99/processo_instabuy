// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instabuy/models/banners.dart' as banners;
import 'package:flutter_application_instabuy/models/collection_items.dart';
import 'package:flutter_application_instabuy/services/api_service.dart';
import 'package:flutter_application_instabuy/services/collection_items_service.dart';
import 'package:flutter_application_instabuy/services/banners_service.dart';
import 'menu_items.dart';
import 'products_page.dart';
import 'package:flutter_application_instabuy/models/item.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {
  List<banners.Banner>? allBanners;
  List<Item>? allPromos;
  List<CollectionItem>? allProducts;
  String? selectedCategory;
  List<Item>? visibleProducts;
  bool isBannersLoaded = false;
  bool isPromosLoaded = false;
  bool isProductsLoaded = false;
  bool isLoaded = false;
  String currCategory = 'Ofertas';
  
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

      final results = ([
        bannerApi.getAllBanners(),
        promoApi.getAllPromos(),
        productsApi.getAllCollectionItems(),
      ]);

      setState(() {
        allBanners = results[0].cast<banners.Banner>();
        allPromos = results[1].cast<Item>();
        visibleProducts = results[1].cast<Item>();
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
    return productsService.fetchCategories(allProducts?.whereType<CollectionItem>().toList() ?? []);
  }

  Future<List<String>> fetchMobileBanners() async {
    final bannersService = BannersService();
    return bannersService.fetchMobileBanners();
  }

  Future<List<Item>> fetchProductsByCategory(List<CollectionItem> allProducts, String category) async {
    final productsService = ProductsService();
    return productsService.fetchProductsByCategory(allProducts, category);
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
              onCategorySelected: (categoryId, categoryName) async {
                setState(() {
                  selectedCategory = categoryId;
                });
                visibleProducts = await fetchProductsByCategory(allProducts!, categoryId);
                currCategory = categoryName;
              },
            )
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
      body: SingleChildScrollView( 
        child: Column(
          children: [
            carouselBanner(),
            currCategory == 'Ofertas' ? 
            Text(currCategory, style: TextStyle(color: Colors.red, fontSize: 36, fontWeight: FontWeight.bold)) : 
            Text(currCategory, style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
            visibleProducts != null ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleProducts!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return ProductCard(item: visibleProducts![index], category: currCategory);
              },
            )
            : const Center(child: CircularProgressIndicator()),
          ],
        ) 
      )
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
            height: 165,
            child: PageView(
              children: snapshot.data!.map((url) {
                return Image.network(
                  url,
                  fit: BoxFit.contain,
                  width: double.infinity,
                );
              }).toList(),
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
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
        },
        child: 
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: Icon(Icons.home_filled, color: Colors.black54),
          ),
      ),
    ],
  );
}
