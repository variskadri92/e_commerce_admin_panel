import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/validators/validation.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());

    return TRoundedContainer(
      child: Form(
          key: controller.titleDescriptionFormKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Basic Info Text
          Text(
            'Basic Information',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Product Title Text Field
          TextFormField(
            controller: controller.title,
            validator: (value) =>
                TValidator.validateEmptyText('Product Title', value),
            decoration: InputDecoration(labelText: 'Product Title'),
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //Product Description Text Field
          SizedBox(
            height: 300,
            child: TextFormField(
              controller: controller.description,
              expands: true,
              maxLines: null,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.top,
              validator: (value) =>
                  TValidator.validateEmptyText('Product Description', value),
              decoration: InputDecoration(
                  labelText: 'Product Description',
                  hintText: 'Enter Product Description here...',
                  alignLabelWithHint: true),
            ),
          )
        ],
      )),
    );
  }
}
