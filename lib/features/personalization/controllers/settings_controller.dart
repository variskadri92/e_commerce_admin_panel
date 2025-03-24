import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

import '../../../data/repositories/settings/settings_repository.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/setting_model.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final settingFormKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingLimitController = TextEditingController();

  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    fetchSettingDetails();
    super.onInit();
  }

  Future<SettingsModel> fetchSettingDetails() async{
    try{
      loading.value = true;
      final settings = await settingRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingLimitController.text = settings.freeShippingLimit ==null ? '': settings.freeShippingLimit.toString();

      loading.value = false;
      return settings;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
      return SettingsModel();
    }
  }

  void updateAppLogo()async{
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

      if(selectedImages != null && selectedImages.isNotEmpty){
        ImageModel selectedImage = selectedImages.first;

        await settingRepository.updateSingleField({'appLogo': selectedImage.url});
        settings.value.appLogo = selectedImage.url;
        settings.refresh();
        TLoaders.successSnackBar(title: 'Success', message: 'Logo Updated Successfully');
      }

      loading.value = false;
    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
    }
  }

  void updateSettingInformation()async{
    try{
      loading.value = true;

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if(!settingFormKey.currentState!.validate()){
        loading.value = false;
        return;
      }

      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate = double.tryParse(taxController.text.trim()) ?? 0.0;
      settings.value.shippingCost = double.tryParse(shippingController.text.trim()) ?? 0.0;
      settings.value.freeShippingLimit = double.tryParse(freeShippingLimitController.text.trim()) ?? 0.0;

      await settingRepository.updateSettingsDetails(settings.value);
      settings.refresh();
      loading.value = false;
      TLoaders.successSnackBar(title: 'Success', message: 'Settings Updated Successfully');

    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
    }
  }
}