import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final createProductController = Get.put(CreateProductController());

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Visibility Header
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Radio buttons for product visibility
          Obx(
            ()=> Column(
              children: [
                _buildVisibilityRadioButton(
                    ProductVisibility.published, 'Published', createProductController),
                _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden',createProductController),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVisibilityRadioButton(ProductVisibility value, String label, CreateProductController controller) {
    return RadioMenuButton<ProductVisibility>(
        value: value,
        groupValue: controller.productVisibility.value,
        onChanged: (selection) {
          controller.productVisibility.value = selection ?? ProductVisibility.published;
        },
        child: Text(label));
  }
}
