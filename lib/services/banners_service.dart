import 'api_service.dart';

class BannersService {
  final BannerApi _bannerApi = BannerApi();

  Future<List<String>> fetchMobileBanners() async {
    List<String> images = [];
    try {
      final banners = await _bannerApi.getAllBanners();
      for(var b in banners) {
        if(b != null && b.isMobile) {
          images.add('https://ibassets.com.br/ib.store.banner/bnr-${b.image}');
        }
      }
      return images;
    } catch (e) {
      print("Erro ao buscar banners: $e");
      return [];
    }
  }
}
