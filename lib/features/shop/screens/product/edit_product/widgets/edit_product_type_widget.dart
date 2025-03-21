import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class EditProductTypeWidget extends StatelessWidget {
  const EditProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;
    return Obx(
          ()=> Row(
        children: [
          Text(
            'Product Type',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            width: TSizes.spaceBtwItems,
          ),

          //Radio Button for single product type
          RadioMenuButton(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) {
              controller.productType.value = value ?? ProductType.single;
            },
            child: Text('Single'),
          ),

          //Radio Button for variable product type
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) {
              controller.productType.value = value ?? ProductType.single;
            },
            child: Text('Variable'),
          ),
        ],
      ),
    );
  }
}
