import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/popups/loaders.dart';

abstract class BaseDataTableController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  ///Abstract method to be implemented by subclasses for fetching items
  Future<List<T>> fetchItems();

  ///Abstract method to be implemented by subclasses for deleting an item
  Future<void> deleteItems(T item);

  ///Abstract method to be implemented by subclasses for checking if an item contains the search query
  bool containsSearchQuery(T item, String query);

  ///Common method for fetching items
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];

      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();


        allItems.assignAll(fetchedItems);
        filteredItems.assignAll(allItems);
        selectedRows.assignAll(List.generate(allItems.length, (_) => false));
      }
    } catch (e) {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Failed to fetch', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///Common method for searching items
  void searchQuery(String query) {
    filteredItems
        .assignAll(allItems.where((item) => containsSearchQuery(item, query)));
  }


  ///Common method for sorting items by a property
  void sortByProperty(int columnIndex, bool ascending, Function(T) property) {
    this.sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  ///Common method for deleting an item
  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  ///Common method for adding an item to lists
  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  ///Common method for updating an item in lists
  void updateItemFromLists(T item) {
    final itemIndex = allItems.indexWhere((i)=> i == item);
    final filteredItemIndex = filteredItems.indexWhere((i)=> i == item);

    if(itemIndex != -1) allItems[itemIndex] = item;
    if(filteredItemIndex != -1) filteredItems[filteredItemIndex] = item;

    filteredItems.refresh();

  }


  ///Common method for confirming and deleting an item
  confirmAndDeleteItem(T item) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(item),
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

  ///Common method for deleting an item on confirmation
  deleteOnConfirm(T item) async{
    try{
      //Remove the confirm dialog
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.popUpCircular();

      //Delete the item
      await deleteItems(item);
      removeItemFromLists(item);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Item Deleted', message: 'Item deleted successfully');
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Failed to delete item', message: e.toString());
    }
  }
}
