import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages(
      {super.key,
      required this.additionalProductImagesURLs,
      this.onTapToAddImages,
      this.onTapToRemoveImages});

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          //Selection to Add Additional Product Images
          Expanded(
            child: GestureDetector(
              onTap: onTapToAddImages,
              child: TRoundedContainer(
                child: Center(
                  child: Column(
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
            ),
          ),

          //Section to Display Uploaded Images
          Expanded(
              child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 80,
                    child: _uploadedImagesOrEmptyList(),
                  )),

              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),

              //Add More Images Button
              TRoundedContainer(
                width: 80,
                height: 80,
                showBorder: true,
                borderColor: TColors.grey,
                backgroundColor: TColors.white,
                onTap: onTapToAddImages,
                child: Center(
                  child: Icon(Iconsax.add),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _uploadedImagesOrEmptyList() {
    return emptyList();
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
      separatorBuilder: (context, index) => SizedBox(
        width: TSizes.spaceBtwItems / 2,
      ),
    );
  }

  ListView _uploadedImages() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImagesURLs.length,
      separatorBuilder: (context, index) => SizedBox(
        width: TSizes.spaceBtwItems / 2,
      ),
      itemBuilder: (context, index) {
        final image = additionalProductImagesURLs[index];
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
          onIconButtonPressed: ()=> onTapToRemoveImages!(index),
        );
      },
    );
  }
}
