import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/brand_category_model.dart';
import 'brand_controller.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final createBrandFormKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> selectedParentCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> availableSubCategories = <CategoryModel>[].obs;
  final RxString searchTextParent = ''.obs;
  final RxString searchTextSub = ''.obs;

  // Get all parent categories (where parentId is empty)
  List<CategoryModel> get parentCategories {
    return CategoryController.instance.allItems
        .where((category) => category.parentId.isEmpty)
        .where((category) => category.name
            .toLowerCase()
            .contains(searchTextParent.value.toLowerCase()))
        .toList();
  }

  // Get subcategories of selected parents
  void updateAvailableSubCategories() {
    availableSubCategories.clear();
    for (var parent in selectedParentCategories) {
      final subs = CategoryController.instance.allItems
          .where((category) => category.parentId == parent.id)
          .where((category) => category.name
              .toLowerCase()
              .contains(searchTextSub.value.toLowerCase()))
          .toList();
      availableSubCategories.addAll(subs);
    }
  }

  // Toggle parent category selection
  void toggleParentSelection(CategoryModel category) {
    if (selectedParentCategories.contains(category)) {
      selectedParentCategories.remove(category);
    } else {
      selectedParentCategories.add(category);
    }
    updateAvailableSubCategories();
  }

  // Toggle subcategory selection
  void toggleSubCategorySelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // Clear all selections
  void clearCategorySelections() {
    selectedParentCategories.clear();
    selectedCategories.clear();
    availableSubCategories.clear();
  }

  ///Method to reset fields
  void resetFields() {
    name.clear();
    imageURL.value = '';
    loading(false);
    isFeatured(false);
    clearCategorySelections();
  }

  ///Pick Thumbnail Image from Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    //Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  ///Register new category
  Future<void> createBrand() async {
    try {
      //Start Loader
      TFullScreenLoader.popUpCircular();

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Check Form Validation
      if (!createBrandFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Map Data
      final newBrand = BrandModel(
        id: '',
        productsCount: 0,
        name: name.text.trim(),
        image: imageURL.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      newBrand.id = await BrandRepository.instance.createBrand(newBrand);

      //Register brand categories if any
      if (selectedCategories.isNotEmpty || selectedParentCategories.isNotEmpty) {
        if (newBrand.id.isEmpty) {
          throw 'Error storing relational data. Try again';
        }

        final allCategories = [...selectedCategories, ...selectedParentCategories];
        final uniqueCategories = allCategories.toSet().toList();

        //Loop through selected brand categories
        for (var category in uniqueCategories) {
          print(category.name);
          //Map data
          final brandCategory =
              BrandCategoryModel(brandId: newBrand.id, categoryId: category.id);
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }

        newBrand.brandCategories ??= [];
        newBrand.brandCategories!.addAll(uniqueCategories);
      }

      //Update all data list
      BrandController.instance.addItemToLists(newBrand);

      //Clear Form
      resetFields();

      //Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'New Brand Created Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }
}
