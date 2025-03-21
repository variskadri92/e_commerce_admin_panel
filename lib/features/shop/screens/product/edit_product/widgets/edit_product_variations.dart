import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_images_controller.dart';
import '../../../../controllers/product/product_variations_controller.dart';
import '../../../../models/product_variation_model.dart';

class EditProductVariations extends StatelessWidget {
  const EditProductVariations({super.key});


  @override
  Widget build(BuildContext context) {
    final variationsController = ProductVariationsController.instance;
    return Obx(
          () => EditProductController.instance.productType.value ==
          ProductType.variable
          ? TRoundedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Product variation header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product Variations',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                    onPressed: () => variationsController
                        .removeVariationsConfirmation(context),
                    child: Text('Remove Variations')),
              ],
            ),

            SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            //Variations List
            if (variationsController.productVariations.isNotEmpty)
              ListView.separated(
                itemCount: variationsController.productVariations.length,
                shrinkWrap: true,
                separatorBuilder: (_, __) => SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                itemBuilder: (_, index) {
                  final variation = variationsController.productVariations[index];
                  return _buildVariationTile(context, index, variation, variationsController);
                },
              )
            else
            //No Variations message
              _buildNoVariationsMessage(),
          ],
        ),
      )
          : SizedBox.shrink(),
    );
  }

  Widget _buildNoVariationsMessage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 200,
              height: 200,
              image: TImages.defaultVariationImageIcon,
              imageType: ImageType.asset,
            ),
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text('No Variations added yet for this product'),
      ],
    );
  }

  Widget _buildVariationTile(BuildContext context, int index, ProductVariationModel variation, ProductVariationsController variationsController) {
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries.map((entry)=> '${entry.key}: ${entry.value}').join(', ')),
      children: [
        //Upload Variation Image
        Obx(
              ()=> TImageUploader(
            right: 0,
            left: null,
            image: variation.image.value.isNotEmpty ? variation.image.value : TImages.defaultImage,
            imageType: variation.image.value.isNotEmpty ? ImageType.network: ImageType.asset,
            onIconButtonPressed: () => ProductImagesController.instance.selectVariationImage(variation),
          ),
        ),

        SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        //Variation Stock, and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: variationsController.stockControllersList[index][variation],
                onChanged: (value)=> variation.stock = int.parse(value),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Add Stock, only numbers are allowed'),
              ),
            ),
            SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                controller: variationsController.priceControllersList[index][variation],
                onChanged: (value)=> variation.price = double.parse(value),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price with up-to 2 decimals'),
              ),
            ),
            SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                controller: variationsController.salePriceControllersList[index][variation],
                onChanged: (value)=> variation.salePrice = double.parse(value),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
                ],
                decoration: InputDecoration(
                    labelText: 'Discounted Price',
                    hintText: 'Price with up-to 2 decimals'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        //Variation Description
        TextFormField(
          controller: variationsController.descriptionControllersList[index][variation],
          onChanged: (value)=> variation.description = value,
          decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Add Description of this variation here ...'),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
