import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

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
