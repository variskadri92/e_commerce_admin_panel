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

  ///Init Data
  void initData(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  ///Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  ///Method to reset fields
  void resetFields() {
    name.clear();
    imageURL.value = '';
    loading(false);
    isFeatured(false);
    selectedCategories.clear();
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

      //Update brand categories if any
      if (selectedCategories.isNotEmpty) {
        await updateBrandCategories(updatedBrand);
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
          title: 'Congratulations',
          message: 'New Category Created Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }

  ///Update categories of this brand
  updateBrandCategories(BrandModel updatedBrand) async {
    //Fetch all brand categories
    final brandCategories =
        await brandRepository.getCategoriesOfSpecificBrand(updatedBrand.id);

    //Selected categoriesIds
    final selectedCategoriesIds = selectedCategories.map((e) => e.id);

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
    final newCategoriesToAdd = selectedCategories
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

    updatedBrand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemFromLists(updatedBrand);
  }

  ///Update products of this brands
  updateBrandInProducts(BrandModel updatedBrand) {}
}
