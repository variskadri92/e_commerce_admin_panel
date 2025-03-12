import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/screens/media/widgets/view_image_details.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/media_controller.dart';
import 'media_folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  MediaContent(
      {super.key,
      required this.allowSelection,
      required this.allowMultipleSelection,
      this.alreadySelectedUrls,
      this.onImagesSelected});

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Media Images Header
          Row(
            children: [
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
              if (allowSelection) buildAddSelectedImagesButton(),
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///Show Media
          Obx(() {
            //Get the selected category
            List<ImageModel> images = _getImagesForSelectedCategory(controller);

            //Load Selected Images from the already selected images only once otherwise
            //on Obx rebuild UI first images will be selected then will auto uncheck
            if (!loadedPreviousSelection) {
              if(alreadySelectedUrls != null && alreadySelectedUrls!.isNotEmpty){
                //Convert already selected urls to A Set for faster lookup
                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);

                for(var image in images){
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if(image.isSelected.value){
                    selectedImages.add(image);
                  }
                }
              }else{
                //If already selected urls is null or empty, set all images unslected
                for(var image in images){
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
            }

            //Loader
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
                          onTap: () => Get.dialog(ViewImagePopup(
                            image: image,
                          )),
                          child: SizedBox(
                            height: 180,
                            width: 140,
                            child: Column(
                              children: [
                                allowSelection ?_buildListWithCheckbox(image): _buildSimpleList(image),
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
                            onPressed: () => controller.loadMoreMediaImages(),
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

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(children: [
      TRoundedImage(
        height: 140,
        width: 140,
        padding: TSizes.sm,
        image: image.url,
        imageType: ImageType.network,
        margin: TSizes.spaceBtwItems / 2,
        backgroundColor: TColors.primaryBackground,
      ),
      Positioned(
          top: TSizes.md,
          right: TSizes.md,
          child: Obx(() => Checkbox(
                value: image.isSelected.value,
                onChanged: (selected) {
                  if (selected != null) {
                    image.isSelected.value = selected;

                    if (selected) {
                      if (!allowMultipleSelection) {
                        //if multiple selection is not allowed, clear the selected images
                        for (var otherImage in selectedImages) {
                          if (otherImage != image) {
                            otherImage.isSelected.value = false;
                          }
                        }
                        selectedImages.clear();
                      }
                      selectedImages.add(image);
                    } else {
                      selectedImages.remove(image);
                    }
                  }
                },
              )))
    ]);
  }

  Widget buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Close Button
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            label: Text('Close'),
            icon: Icon(Iconsax.close_circle),
          ),
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            icon: Icon(Iconsax.image),
            onPressed: () => Get.back(result: selectedImages),
            label: Text('Add'),
          ),
        )
      ],
    );
  }
}
