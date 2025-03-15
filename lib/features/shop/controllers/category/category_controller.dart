import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

import '../../../../data/repositories/category/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

  //Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await _categoryRepository.getAllCategories();

        allItems.assignAll(fetchedItems);
        filteredItems.assignAll(allItems);
        selectedRows.assignAll(List.generate(allItems.length, (_) => false));

        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(
          title: 'Failed to fetch categories', message: e.toString());
    }
  }

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  searchQuery(String query) {
    filteredItems.assignAll(allItems.where(
        (item) => item.name.toLowerCase().contains(query.toLowerCase())));
  }

  confirmAndDeleteItem(CategoryModel category) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(category),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
              ),
            ),
            child: Text('Ok')),
      ),
      cancel: SizedBox(
        width: 80,
        child: ElevatedButton(
            onPressed: ()=> Get.back(),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
              ),
            ),
            child: Text('Cancel')),
      ),
    );
  }

  deleteOnConfirm(CategoryModel category) async{
    try{
      //Remove the confirm dialog
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.popUpCircular();

      //Delete the item
      await _categoryRepository.deleteCategories(category.id);
      removeItemFromLists(category);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Item Deleted', message: 'Item deleted successfully');
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Failed to delete item', message: e.toString());
    }
  }


  ///Method for removing an item from list
  void removeItemFromLists(CategoryModel category) {
    allItems.remove(category);
    filteredItems.remove(category);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));
  }

}
