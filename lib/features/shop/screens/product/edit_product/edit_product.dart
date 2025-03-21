import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/responsive_screens/edit_product_mobile.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initProductData(product);
    });

    return SiteLayout(
      desktop: EditProductDesktop(
        product: product,
      ),
      mobile: EditProductMobile(
        product: product,
      ),
    );
  }
}
