import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../controllers/product/product_images_controller.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());

    return SizedBox(
      height: 300,
      child: Column(
        children: [
          // Main Box for First Image
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.selectMultipleProductImages(),
              child: TRoundedContainer(
                showBorder: true,
                borderColor: TColors.grey,
                child: Center(
                  child: controller.additionalProductImagesUrls.isNotEmpty
                      ? Image.network(
                    controller.additionalProductImagesUrls.first, // First image as main
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                      : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        TImages.defaultMultiImageIcon,
                        width: 50,
                        height: 50,
                      ),
                      Text('Add Additional Product Images'),
                    ],
                  ),
                ),
              ),
            )),
          ),

          // Section to Display Remaining Uploaded Images
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 80,
                    child: Obx(() => _uploadedImagesOrEmptyList(controller)),
                  ),
                ),

                SizedBox(width: TSizes.spaceBtwItems / 2),

                // Add More Images Button
                TRoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: TColors.grey,
                  backgroundColor: TColors.white,
                  onTap: () => controller.selectMultipleProductImages(),
                  child: Center(child: Icon(Iconsax.add)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadedImagesOrEmptyList(ProductImagesController controller) {
    // Show only remaining images (excluding the first one)
    return controller.additionalProductImagesUrls.length > 1
        ? _uploadedImages(controller)
        : emptyList();
  }

  Widget emptyList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) => TRoundedContainer(
        backgroundColor: TColors.primaryBackground,
        width: 80,
        height: 80,
      ),
      separatorBuilder: (context, index) => SizedBox(width: TSizes.spaceBtwItems / 2),
    );
  }

  ListView _uploadedImages(ProductImagesController controller) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: controller.additionalProductImagesUrls.length - 1, // Excluding the first image
      separatorBuilder: (context, index) => SizedBox(width: TSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        final image = controller.additionalProductImagesUrls[index + 1]; // Skip first image
        return TImageUploader(
          top: 0,
          right: 0,
          width: 80,
          height: 80,
          left: null,
          bottom: null,
          image: image,
          imageType: ImageType.network,
          icon: Iconsax.trash,
          onIconButtonPressed: () => controller.removeImage(index + 1), // Skip first image
        );
      },
    );
  }
}
