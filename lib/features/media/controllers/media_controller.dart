import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/circular_loader.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/media/media_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/dialogs.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

///Controller to manage Media Operations
class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late DropzoneViewController dropzoneController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;

  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  //Get Images
  void getMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.fetchImagesFromDatabase(
          selectedPath.value, initialLoadCount);
      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Unable to fetch images', message: e.toString());
    }
  }

  void loadMoreMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isNotEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isNotEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isNotEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isNotEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isNotEmpty) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value,
          initialLoadCount,
          targetList.last.createdAt ?? DateTime.now());
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Unable to fetch images', message: e.toString());
    }
  }

  Future<void> selectLocalImages() async {
    print('Enter');
    final files = await dropzoneController
        .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);
    print('Files selected ${files.length}');

    if (files.isNotEmpty) {
      print('Files selected ${files.length}');
      for (var file in files) {
        print('Files selected ${files.length}');

        final bytes = await dropzoneController.getFileData(file);

        // Extract file metadata
        final filename = await dropzoneController.getFilename(file);
        final mimeType = await dropzoneController.getFileMIME(file);
        final image = ImageModel(
            url: '',
            folder: '',
            filename: filename,
            contentType: mimeType,
            localImageToDisplay: Uint8List.fromList(bytes));
        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImageConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
          title: 'Select Folder', message: 'Please select a folder');
      return;
    }

    TDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content:
          'Are you sure you want to upload these images in ${selectedPath.value.name.toUpperCase()}?',
    );
  }

  // Future<void> uploadImages() async {
  //   try {
  //     //Remove confirmation box
  //     Get.back();
  //
  //     //Loader
  //     uploadImagesLoader();
  //
  //     //Get the selected category
  //     MediaCategory selectedCategory = selectedPath.value;
  //
  //     //Get the list of update
  //     RxList<ImageModel> targetList;
  //
  //     // Check the selected category and update the corresponding list
  //     switch (selectedCategory) {
  //       case MediaCategory.banners:
  //         targetList = allBannerImages;
  //         break;
  //       case MediaCategory.brands:
  //         targetList = allBrandImages;
  //         break;
  //       case MediaCategory.categories:
  //         targetList = allCategoryImages;
  //         break;
  //       case MediaCategory.products:
  //         targetList = allProductImages;
  //         break;
  //       case MediaCategory.users:
  //         targetList = allUserImages;
  //         break;
  //       default:
  //         return;
  //     }
  //
  //     // Upload and add images to the target list
  //     // Using a reverse loop to avoid 'Concurrent modification during iteration' error
  //     for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
  //       var selectedImage = selectedImagesToUpload[i];
  //       // Upload Image to the Storage
  //       final ImageModel uploadedImage =
  //           await mediaRepository.uploadImageFileInStorage(
  //         fileData: selectedImage.localImageToDisplay!,
  //         mimeType: selectedImage.contentType!,
  //         path: getSelectedPath(),
  //         imageName: selectedImage.filename,
  //       );
  //
  //       // Upload Image to the Firestore
  //       uploadedImage.mediaCategory = selectedCategory.name;
  //       final id =
  //           await mediaRepository.uploadImageFileInDatabase(uploadedImage);
  //       uploadedImage.id = id;
  //       selectedImagesToUpload.removeAt(i);
  //       targetList.add(uploadedImage);
  //     }
  //     // Stop Loader after successful upload
  //     TFullScreenLoader.stopLoading();
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //
  //     TLoaders.warningSnackBar(
  //         title: 'Error uploading images', message: e.toString());
  //   }
  // }

  Future<void> uploadImages() async {
    try {
      // Close confirmation dialog
      Get.back();

      // Show loader
      uploadImagesLoader();

      // Get the selected category
      MediaCategory selectedCategory = selectedPath.value;
      if (selectedCategory == MediaCategory.folders) {
        TLoaders.warningSnackBar(title: 'Select Folder', message: 'Please select a folder');
        return;
      }

      // Get corresponding image list
      RxList<ImageModel> targetList;
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // Firebase storage path
      String path = getSelectedPath();

      // Upload all images **in parallel**
      List<Future<ImageModel>> uploadTasks = selectedImagesToUpload.map((selectedImage) async {
        return await mediaRepository.uploadImageFileInStorage(
          fileData: selectedImage.localImageToDisplay!,
          mimeType: selectedImage.contentType!,
          path: path,
          imageName: selectedImage.filename,
        );
      }).toList();

      // Wait for all uploads to complete
      List<ImageModel> uploadedImages = await Future.wait(uploadTasks);

      // Add media category to each uploaded image
      for (var img in uploadedImages) {
        img.mediaCategory = selectedCategory.name;
      }

      // **Batch write to Firestore**
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var uploadedImage in uploadedImages) {
        DocumentReference docRef = FirebaseFirestore.instance.collection("Images").doc();
        batch.set(docRef, uploadedImage.toJson());
      }
      await batch.commit();

      // Update UI list
      targetList.addAll(uploadedImages);
      selectedImagesToUpload.clear();

      // Stop loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Upload Complete', message: 'All images uploaded successfully!');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error Uploading', message: e.toString());
    }
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
                child: AlertDialog(
              title: Text('Uploading Images'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Image.asset(
                  TImages.uploadingImageIllustration,
                  height: 300,
                  width: 300,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text('Uploading Images...'),
              ]),
            )));
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  ///Popup Confirmation to remove cloud image
  void removeCloudImageConfirmation(ImageModel image) {
    TDialogs.defaultDialog(
      context: Get.context!,
      content: 'Are you sure you want to delete this image?',
      onConfirm: () {
        Get.back();
        removeCloudImage(image);
      },
    );
  }

  void removeCloudImage(ImageModel image) async{
    try {
      Get.back();
      //Show Loader
      Get.defaultDialog(
          title: '',
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: PopScope(
              canPop: false,
              child: SizedBox(
                width: 150,
                height: 150,
                child: TCircularLoader(),
              )));

      //Delete Image
      await mediaRepository.deleteFileFromStorage(image);

      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      //Remove Image from the list
      targetList.remove(image);
      update();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Image Deleted',
          message: 'Image Deleted Successfully from Cloud Storage');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Unable to delete image', message: e.toString());
    }
  }
}
