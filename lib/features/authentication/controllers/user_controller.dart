import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../media/controllers/media_controller.dart';
import '../../media/models/image_model.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  ///Obs variable
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final userFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();

  final userRepository = Get.put(UserRepository());


  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  ///Fetch user details from repository
  Future<UserModel> fetchUserDetails()async{
    try{
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }

  void updateProfilePicture()async{
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

      if(selectedImages != null && selectedImages.isNotEmpty){
        ImageModel selectedImage = selectedImages.first;

        await userRepository.updateSingleField({'ProfilePicture': selectedImage.url});

        user.value.profilePicture = selectedImage.url;
        user.refresh();
        TLoaders.successSnackBar(title: 'Success', message: 'Profile Picture Updated Successfully');
      }

      loading.value = false;
    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
    }
  }

  void updateUserInformation()async{
    try{
      loading.value = true;

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if(!userFormKey.currentState!.validate()){
        loading.value = false;
        return;
      }

      user.value.fullName = fullNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();

      await userRepository.updateUserDetails(user.value);
      user.refresh();

      loading.value = false;
      TLoaders.successSnackBar(title: 'Success', message: 'Profile Updated Successfully');

    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
    }
  }
}