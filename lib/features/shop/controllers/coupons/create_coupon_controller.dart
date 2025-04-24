import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/coupons/coupon_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/coupon_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../../../data/repositories/coupon/coupon_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class CreateCouponController extends GetxController{
  static CreateCouponController get instance => Get.find();

  final createCouponFormKey = GlobalKey<FormState>();

  final loading = false.obs;
  final code = TextEditingController();
  final discountValue = TextEditingController();
  final minimumOrderValue = TextEditingController();
  final isActive = false.obs;

  final selectedDiscountType = DiscountType.percentage.obs;
  final selectedExpiryDate = Rxn<DateTime>();

  Future<void> createCoupon()async{
    try{
      TFullScreenLoader.popUpCircular();

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Check Form Validation
      if (!createCouponFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Map Data
      final newCoupon = CouponModel(
        code: code.text,
        discountType: selectedDiscountType.value.toString(),
        discountValue: double.parse(discountValue.text),
        minimumOrderValue: double.parse(minimumOrderValue.text),
        isActive: isActive.value,
        expiryDate: selectedExpiryDate.value!,
      );

      await CouponRepository.instance.createCoupon(newCoupon);
      CouponController.instance.addItemToLists(newCoupon);
      resetFields();

      //Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'New Coupon Created Successfully');
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }

  void pickExpiryDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(Duration(days: 365)),
    );
    if (picked != null) selectedExpiryDate.value = picked;
  }

  void resetFields() {
    code.clear();
    discountValue.clear();
    minimumOrderValue.clear();
    isActive(false);
    selectedDiscountType(DiscountType.percentage);
    selectedExpiryDate.value = null;
  }
}