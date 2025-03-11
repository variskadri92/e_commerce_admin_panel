import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/media_controller.dart';
import 'media_folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Media Images Header
          Row(
            children: [
              //Folders Dropdown
              Text(
                'Select Folder',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                    controller.getMediaImages();
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///Show Media
          Obx(() {
            //Get the selected category
            List<ImageModel> images = _getImagesForSelectedCategory(controller);

            if (controller.loading.value && images.isEmpty) {
              return const TLoaderAnimation();
            }

            //Empty Widget
            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: TSizes.spaceBtwItems / 2,
                  runSpacing: TSizes.spaceBtwItems / 2,
                  children: images
                      .map(
                        (image) => GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            height: 180,
                            width: 140,
                            child: Column(
                              children: [
                                _buildSimpleList(image),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: TSizes.sm),
                                  child: Text(
                                    image.filename,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                ///Load more Media Button
                if (!controller.loading.value)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: TSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: ()=> controller.loadMoreMediaImages(),
                            label: Text('Load More'),
                            icon: Icon(Iconsax.arrow_down),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getImagesForSelectedCategory(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      //print(controller.allBannerImages);
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories &&
        controller.allCategoryImages.isNotEmpty) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your Desired Folder',
        animation: TImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      height: 140,
      width: 140,
      padding: TSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }
}
