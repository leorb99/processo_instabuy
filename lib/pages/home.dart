import 'package:flutter/material.dart';
import 'package:flutter_application_instabuy/models/banners.dart' as banners;
import 'package:flutter_application_instabuy/models/products.dart' as products;
import 'package:flutter_application_instabuy/models/promos.dart' as promos;
import 'package:flutter_application_instabuy/services/api_service.dart';
import 'package:flutter_application_instabuy/services/products_service.dart';
import 'package:popover/popover.dart';
import 'menu_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {
  List<banners.Welcome>? allBanners;
  List<promos.Welcome>? allPromos;
  List<products.Welcome>? allProducts;
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
    final apiService = Api();
    await apiService.fetchData();
    setState(() {
      isLoaded = true;
    });
    final bannerApi = BannerApi();
    final promoApi = PromoApi();
    final productsApi = ProductsApi();
    allBanners = (await bannerApi.getAllBanners()).cast<banners.Welcome>();
    allPromos = (await promoApi.getAllPromos()).cast<promos.Welcome>();
    allProducts = (await productsApi.getAllProducts()).cast<products.Welcome>();
    setState(() {
      isBannersLoaded = true;
      isPromosLoaded = true;
      isProductsLoaded = true;
    });
  }

  Future<List<String>> fetchCategories() async {
    final productsService = ProductsService();
    return await productsService.listCategories();
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
      ]),
      
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
