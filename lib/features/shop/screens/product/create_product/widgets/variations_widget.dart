import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
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
              TextButton(onPressed: () {}, child: Text('Remove Variations')),
            ],
          ),

          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Variations List
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            separatorBuilder: (_, __) => SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemBuilder: (_, index) {
              return _buildVariationTile();
            },
          ),

          //No Variations message
          _buildNoVariationsMessage(),
        ],
      ),
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

  Widget _buildVariationTile() {
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      title: Text('Color : Green'),
      children: [
        //Upload Variation Image
        TImageUploader(
          right: 0,
          left: null,
          image: TImages.defaultImage,
          imageType: ImageType.asset,
          onIconButtonPressed: () {},
        ),

        SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        //Variation Stock, and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price with up-to 2 decimals'),
              ),
            ),
            SizedBox(width: TSizes.spaceBtwInputFields,),

            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))],
                decoration: InputDecoration(
                    labelText: 'Discounted Price',
                    hintText: 'Price with up-to 2 decimals'),
              ),
            ),

          ],
        ),
        SizedBox(height: TSizes.spaceBtwInputFields,),

        //Variation Description
        TextFormField(
          decoration: InputDecoration(labelText: 'Description',hintText: 'Add Description of this variation here ...'),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),
      ],
    );
  }
}
