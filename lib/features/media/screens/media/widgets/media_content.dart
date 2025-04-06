import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSelection,
    this.alreadySelectedUrls,
    this.onImagesSelected,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    final MediaController controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header
          Row(
            children: [
              Row(
                children: [
                  // Folders Dropdown
                  Text(
                    'Select Folder',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  MediaFolderDropdown(
                    onChanged: (MediaCategory? newValue) {
                      if (newValue != null) {
                        controller.selectedPath.value = newValue;
                        controller.getMediaImages();
                        // Clear selections when folder changes
                        controller.selectedImages.clear();
                        controller.loadedPreviousSelection.value = false;
                      }
                    },
                  ),
                ],
              ),
              if (allowSelection) _buildSelectionButtons(controller),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Show Media
          Obx(() {
            final images = _getImagesForSelectedCategory(controller);

            /// Initialize selections WHEN IMAGES ARE AVAILABLE
            if (images.isNotEmpty && !controller.loadedPreviousSelection.value) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _initializeSelections(controller, images);
                controller.loadedPreviousSelection.value = true;
              });
            }

            if (controller.loading.value && images.isEmpty) {
              return const TLoaderAnimation();
            }

            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              children: [
                _buildImageGrid(images),
                _buildLoadMoreButton(controller),
              ],
            );
          }),
        ],
      ),
    );
  }

  void _initializeSelections(MediaController controller, List<ImageModel> images) {
    controller.selectedImages.clear();
    if (alreadySelectedUrls != null && alreadySelectedUrls!.isNotEmpty) {
      final selectedUrlsSet = alreadySelectedUrls!.toSet();
      for (var image in images) {
        image.isSelected.value = selectedUrlsSet.contains(image.url);
        if (image.isSelected.value) {
          controller.selectedImages.add(image);
        }
      }
    }
    controller.update();
  }

  Widget _buildImageGrid(List<ImageModel> images) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: TSizes.spaceBtwItems / 2,
      runSpacing: TSizes.spaceBtwItems / 2,
      children: images.map((image) => _buildImageItem(image)).toList(),
    );
  }

  Widget _buildImageItem(ImageModel image) {
    return GestureDetector(
      onTap: () => Get.dialog(ViewImagePopup(image: image)),
      child: SizedBox(
        height: 180,
        width: 140,
        child: Column(
          children: [
            allowSelection ? _buildListWithCheckbox(image) : _buildSimpleList(image),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: Text(
                  image.filename,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
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
            onChanged: allowSelection ? (selected) {
              if (selected != null) {
                image.isSelected.value = selected;
                if (selected) {
                  if (!allowMultipleSelection) {
                    // Clear previous selections
                    for (var img in MediaController.instance.selectedImages) {
                      img.isSelected.value = false;
                    }
                    MediaController.instance.selectedImages.clear();
                  }
                  MediaController.instance.selectedImages.add(image);
                } else {
                  MediaController.instance.selectedImages.remove(image);
                }
              }
            } : null,
          )),
        )
      ],
    );
  }

  Widget _buildSelectionButtons(MediaController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            label: const Text('Close'),
            icon: const Icon(Iconsax.close_circle),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            icon: const Icon(Iconsax.image),
            onPressed: () => Get.back(result: controller.selectedImages),
            label: const Text('Add'),
          ),
        )
      ],
    );
  }

  Widget _buildLoadMoreButton(MediaController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: TSizes.buttonWidth,
            child: ElevatedButton.icon(
              onPressed: () => controller.loadMoreMediaImages(),
              label: const Text('Load More'),
              icon: const Icon(Iconsax.arrow_down),
            ),
          )
        ],
      ),
    );
  }

  List<ImageModel> _getImagesForSelectedCategory(MediaController controller) {
    List<ImageModel> images = [];

    switch (controller.selectedPath.value) {
      case MediaCategory.banners:
        images = controller.allBannerImages.where((image) => image.url.isNotEmpty).toList();
        break;
      case MediaCategory.brands:
        images = controller.allBrandImages.where((image) => image.url.isNotEmpty).toList();
        break;
      case MediaCategory.categories:
        images = controller.allCategoryImages.where((image) => image.url.isNotEmpty).toList();
        break;
      case MediaCategory.products:
        images = controller.allProductImages.where((image) => image.url.isNotEmpty).toList();
        break;
      case MediaCategory.users:
        images = controller.allUserImages.where((image) => image.url.isNotEmpty).toList();
        break;
      default:
        return [];
    }

    // Sort by createdAt in descending order (newest first)
    images.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
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