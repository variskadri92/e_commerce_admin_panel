import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;



  ///Init Data
  void initData(CategoryModel category) {
    name.text = category.name;
    imageURL.value = category.image;
    isFeatured.value = category.isFeatured;
    selectedParent.value = category.parentId.isNotEmpty
        ? CategoryController.instance.allItems.firstWhere(
          (item) => item.id == category.parentId,
      orElse: () => CategoryModel.empty(),
    )
        : CategoryModel.empty(); // Initialize with empty model if no parent
  }

  ///Method to reset fields
  void resetFields() {
    name.clear();
    imageURL.value = '';
    loading(false);
    isFeatured(false);
    selectedParent(CategoryModel.empty());
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

  ///Register updated category
  Future<void> updateCategory(CategoryModel updatedCategory) async {
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
      updatedCategory.name = name.text.trim();
      updatedCategory.image = imageURL.value;
      updatedCategory.isFeatured = isFeatured.value;
      updatedCategory.parentId = selectedParent.value.id;
      updatedCategory.updatedAt = DateTime.now();

     await CategoryRepository.instance.updateCategory(updatedCategory);

     CategoryController.instance.updateItemFromLists(updatedCategory);

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
}
