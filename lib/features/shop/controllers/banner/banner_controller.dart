import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/banner_model.dart';

import '../../../../data/repositories/banners/banners_repository.dart';

class BannerController extends BaseDataTableController<BannerModel>{

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
  String formatRoute(String route){
    if(route.isEmpty) return '';
    //Remove the '/' from the beginning of the route
    String formatted = route.substring(1);

    //Capitalize the first letter of each word
    formatted = formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }
}