import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/data/repositories/coupon/coupon_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/coupons/coupon_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/coupon_model.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class EditCouponController extends GetxController {
  static EditCouponController get instance => Get.find();

  final editCouponFormKey = GlobalKey<FormState>();
  late String originalCode;

  final loading = false.obs;
  final code = TextEditingController();
  final discountValue = TextEditingController();
  final minimumOrderValue = TextEditingController();
  final isActive = false.obs;

  final selectedDiscountType = DiscountType.percentage.obs;
  final selectedExpiryDate = Rxn<DateTime>();

  ///Init Data
  void initData(CouponModel coupon) {
    originalCode = coupon.code;
    code.text = coupon.code;
    discountValue.text = coupon.discountValue.toString();
    minimumOrderValue.text = coupon.minimumOrderValue.toString();
    isActive.value = coupon.isActive;
    selectedDiscountType.value = DiscountType.values
        .firstWhere((type) => type.toString() == coupon.discountType);
    selectedExpiryDate.value = coupon.expiryDate;
  }

  Future<void> updateCoupon(CouponModel updatedCoupon) async {
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
      if (!editCouponFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Map Data
      updatedCoupon.code = code.text.trim();
      updatedCoupon.discountValue = double.parse(discountValue.text.trim());
      updatedCoupon.minimumOrderValue =
          double.parse(minimumOrderValue.text.trim());
      updatedCoupon.isActive = isActive.value;
      updatedCoupon.discountType = selectedDiscountType.value.toString();
      updatedCoupon.expiryDate = selectedExpiryDate.value!;

      await CouponRepository.instance.updateCoupon(originalCode,updatedCoupon);

      CouponController.instance.updateItemFromLists(updatedCoupon);

      resetFields();
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Coupon Updated Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }

  void resetFields() {
    code.clear();
    discountValue.clear();
    minimumOrderValue.clear();
    isActive.value = false;
    selectedDiscountType.value = DiscountType.percentage;
    selectedExpiryDate.value = null;
  }
}
