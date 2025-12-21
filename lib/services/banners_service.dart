import 'api_service.dart';

class BannersService {
  final BannerApi _bannerApi = BannerApi();

  List<String> fetchMobileBanners() {
    List<String> images = [];
    try {
      final banners = _bannerApi.getAllBanners();
      for(var b in banners) {
        if(b.isMobile) {
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
