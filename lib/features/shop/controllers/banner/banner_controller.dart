import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/banner_model.dart';

import '../../../../data/repositories/banners/banners_repository.dart';

class BannerController extends BaseDataTableController<BannerModel>{
  static BannerController get instance => Get.find();
  final _bannerRepository = Get.put(BannersRepository());

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }

  @override
  Future<void> deleteItems(BannerModel item) async{
    await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async{
    return await _bannerRepository.getAllBanners();
  }


  ///Method for formatting a route string
  String formatRoute(String route) {
    if (route.isEmpty) return '';

    // Remove the '/' if present
    String formatted = route.startsWith('/') ? route.substring(1) : route;

    // Handle empty string after substring
    if (formatted.isEmpty) return '';

    // Capitalize the first letter
    return formatted[0].toUpperCase() + formatted.substring(1);
  }
}