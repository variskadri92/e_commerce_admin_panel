import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_variation_model.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  //Rx Observable for selected thumbnail image
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  //List to store additional product images
  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  ///Pick Thumbnail Image from Media
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    //Handle the selected image
    if (selectedImages != null && selectedImages.isNotEmpty) {
      //Set the selected image to main image or perform any other action
      ImageModel selectedImage = selectedImages.first;

      //Update the main image URL
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  ///Pick Multiple Image from Media
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    final selectedImages = await controller.selectImagesFromMedia(multipleSelection: true,selectedUrls: additionalProductImagesUrls);

    //Handle the selected image
    if (selectedImages != null && selectedImages.isNotEmpty) {
    additionalProductImagesUrls.assignAll(selectedImages.map((e)=> e.url));

    }
  }

  ///Function to remove Product image
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }

  void selectVariationImage(ProductVariationModel variation) async{
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    //Handle the selected image
    if (selectedImages != null && selectedImages.isNotEmpty) {
      //Set the selected image to main image or perform any other action
      ImageModel selectedImage = selectedImages.first;

      //Update the main image URL
      variation.image.value = selectedImage.url;
    }

  }
}
