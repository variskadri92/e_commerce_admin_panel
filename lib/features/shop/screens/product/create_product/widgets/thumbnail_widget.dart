import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: TRoundedImage(
                        width: 200,
                        height: 220,
                        image: TImages.defaultSingleImageIcon,
                        imageType: ImageType.asset,
                      ),
                    ),
                  ],
                ),

                //Add Thumbnail Button
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () {},
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
