import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/dialogs.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  void addNewAttribute() {

    //Validate form
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }

    //Add new attribute to list
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList()));

    //Clear text fields
    attributeName.clear();
    attributes.clear();
  }

  void removeAttribute(int index, BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      onConfirm: (){
        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        ProductVariationsController.instance.productVariations.value = [];
      }
    );
  }

  void resetProductAttributes(){
    productAttributes.clear();
  }
}
