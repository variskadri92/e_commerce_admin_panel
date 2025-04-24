import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(
          () =>
      controller.productType.value == ProductType.single ? Form(
        key: controller.stockPriceFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Stock
            FractionallySizedBox(
              widthFactor: 0.45,
              child: TextFormField(
                controller: controller.stock,
                decoration: InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Add Stock, only numbers are allowed'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    TValidator.validateEmptyText('Stock', value),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),

            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            //Pricing
            Row(
              children: [
                //Price
                Expanded(
                  child: TextFormField(
                    controller: controller.price,
                    validator: (value) =>
                        TValidator.validateEmptyText('Price', value),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}$'))
                    ],
                    decoration: InputDecoration(
                        labelText: 'Price',
                        hintText: 'Price with up-to 2 decimals'),
                  ),
                ),

                SizedBox(width: TSizes.spaceBtwItems,),

                //Sale Price
                Expanded(
                  child: TextFormField(
                    controller: controller.salePrice,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}$'))
                    ],
                    decoration: InputDecoration(
                        labelText: 'Discounted Price',
                        hintText: 'Price with up-to 2 decimals'),
                  ),
                ),
              ],
            )
          ],
        ),) : const SizedBox.shrink(),
    );
  }
}
