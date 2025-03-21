import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
    return TRoundedContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //Product Thumbnail Text
        Text(
          'Product Thumbnail',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Container for Product Thumbnail
        TRoundedContainer(
          height: 300,
          backgroundColor: TColors.primaryBackground,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Thumbnail Image
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        ()=> TRoundedImage(
                          width: 200,
                          height: 220,
                          image: controller.selectedThumbnailImageUrl.value ?? TImages.defaultSingleImageIcon,
                          imageType: controller.selectedThumbnailImageUrl.value == null ? ImageType.asset : ImageType.network,
                        ),
                      ),
                    ),
                  ],
                ),

                //Add Thumbnail Button
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: ()=> controller.selectThumbnailImage(),
                    child: Text('Thumbnail'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
