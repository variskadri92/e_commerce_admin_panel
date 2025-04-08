import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/brand_category_model.dart';
import 'brand_controller.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final editBrandFormKey = GlobalKey<FormState>();
  final brandRepository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> selectedParentCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> availableSubCategories = <CategoryModel>[].obs;
  final RxString searchTextParent = ''.obs;
  final RxString searchTextSub = ''.obs;

  ///Init Data
  void initData(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      // Separate parent categories and subcategories
      final allCategories = brand.brandCategories!;
      selectedCategories
          .addAll(allCategories.where((cat) => cat.parentId.isNotEmpty));
      selectedParentCategories
          .addAll(allCategories.where((cat) => cat.parentId.isEmpty));

      updateAvailableSubCategories();
    }
  }

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
      // Remove all subcategories of this parent
      selectedCategories.removeWhere((cat) => cat.parentId == category.id);
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
      // Ensure parent is selected
      if (category.parentId.isNotEmpty &&
          !selectedParentCategories.any((p) => p.id == category.parentId)) {
        final parent = CategoryController.instance.allItems
            .firstWhere((p) => p.id == category.parentId);
        selectedParentCategories.add(parent);
        updateAvailableSubCategories();
      }
    }
  }

  ///Method to reset fields
  void resetFields() {
    name.clear();
    imageURL.value = '';
    loading(false);
    isFeatured(false);
    selectedCategories.clear();
    selectedParentCategories.clear();
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

  ///Register updated brand
  Future<void> updateBrand(BrandModel updatedBrand) async {
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
      if (!editBrandFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Is Data Updated
      bool isBrandUpdated = false;
      if (updatedBrand.image != imageURL.value ||
          updatedBrand.name != name.text.trim() ||
          updatedBrand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        //Map Data
        updatedBrand.name = name.text.trim();
        updatedBrand.image = imageURL.value;
        updatedBrand.isFeatured = isFeatured.value;
        updatedBrand.updatedAt = DateTime.now();

        await brandRepository.updateBrand(updatedBrand);
      }

      // Combine selected categories and parent categories
      final allSelectedCategories = [
        ...selectedCategories,
        ...selectedParentCategories
      ];

      // Update brand categories if any changes
      if (allSelectedCategories.isNotEmpty ||
          (updatedBrand.brandCategories?.isNotEmpty ?? false)) {
        await updateBrandCategories(updatedBrand, allSelectedCategories);
      }

      //Update Brand Data in Products
      if (isBrandUpdated) {
        await updateBrandInProducts(updatedBrand);
      }

      //Clear Form
      resetFields();

      //Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Brand updated successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }

  ///Update categories of this brand
  Future<void> updateBrandCategories(
    BrandModel updatedBrand,
    List<CategoryModel> allSelectedCategories,
  ) async {
    //Fetch all brand categories
    final brandCategories =
        await brandRepository.getCategoriesOfSpecificBrand(updatedBrand.id);

    //Selected categoriesIds
    final selectedCategoriesIds =
        allSelectedCategories.map((e) => e.id).toSet();

    //Identify which categories to delete
    final categoriesToDelete = brandCategories
        .where((existingCategory) =>
            !selectedCategoriesIds.contains(existingCategory.categoryId))
        .toList();

    //Delete unselected categories
    for (var categoryToDelete in categoriesToDelete) {
      await BrandRepository.instance
          .deleteBrandCategory(categoryToDelete.id ?? '');
    }

    //Identify new categories to add
    final newCategoriesToAdd = allSelectedCategories
        .where((newCategory) => !brandCategories.any((existingCategory) =>
            existingCategory.categoryId == newCategory.id))
        .toList();

    //Add new categories
    for (var newCategory in newCategoriesToAdd) {
      final brandCategory = BrandCategoryModel(
          brandId: updatedBrand.id, categoryId: newCategory.id);
      brandCategory.id =
          await BrandRepository.instance.createBrandCategory(brandCategory);
    }

    // Update the brand's category list
    updatedBrand.brandCategories = allSelectedCategories;
    BrandController.instance.updateItemFromLists(updatedBrand);
  }

  ///Update products of this brands
  Future<void> updateBrandInProducts(BrandModel updatedBrand) async {
    // Implement your product update logic here
  }
}