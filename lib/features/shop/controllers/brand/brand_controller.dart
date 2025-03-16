import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../models/brand_model.dart';
import '../category/category_controller.dart';

class BrandController extends BaseDataTableController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(BrandModel item) async{
    await _brandRepository.deleteBrand(item);
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
            (BrandModel b) => b.name.toLowerCase());
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    //Fetch brands
    final fetchedBrands = await _brandRepository.getAllBrands();
    //Fetch brand categories
    final fetchedBrandCategories =
        await _brandRepository.getAllBrandCategories();

    //Fetch all categories is data does not already exist
    if (categoryController.allItems.isNotEmpty) {
      await categoryController.fetchItems();
    }

    //Loop all brands and fetch categories for each brand
    for (var brand in fetchedBrands) {
      //Extract categoryIds from the document
      List<String> categoryIds = fetchedBrandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();
      
      brand.brandCategories = categoryController.allItems.where((category)=> categoryIds.contains(category.id)).toList();
    }
    return fetchedBrands;
  }
}
