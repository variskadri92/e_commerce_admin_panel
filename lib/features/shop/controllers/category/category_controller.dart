import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

import '../../../../data/repositories/category/category_repository.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  //Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async{
    try{
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if(allItems.isEmpty){
        fetchedItems = await _categoryRepository.getAllCategories();

        allItems.assignAll(fetchedItems);
        filteredItems.assignAll(allItems);

        isLoading.value = false;

      }
    }catch(e){
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Failed to fetch categories',message: e.toString());
    }
  }

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b){
      if(ascending){
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      }else{
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  sortByParentName(int columnIndex, bool ascending) {

    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b){
      if(ascending){
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      }else{
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }
}