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
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  ///Toggle Category Selection
  void toggleSelection(CategoryModel category){
    if(selectedCategories.contains(category)){
      selectedCategories.remove(category);
    }else{
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
      if (!formKey.currentState!.validate()) {
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
      if(selectedCategories.isNotEmpty){
        if(newBrand.id.isEmpty) throw 'Error storing relational data. Try again';

        //Loop through selected brand categories
        for(var category in selectedCategories) {
          //Map data
          final brandCategory = BrandCategoryModel(brandId: newBrand.id,categoryId: category.id);
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }

        newBrand.brandCategories ??=[];
        newBrand.brandCategories!.addAll(selectedCategories);
      }

      //Update all data list
      BrandController.instance.addItemToLists(newBrand);

      //Clear Form
      resetFields();
      

      //Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'New Brand Created Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }




}
