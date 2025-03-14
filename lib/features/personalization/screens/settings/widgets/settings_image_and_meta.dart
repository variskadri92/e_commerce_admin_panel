import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class SettingsImageAndMeta extends StatelessWidget {
  const SettingsImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              //User Image
              TImageUploader(
                right: 10,
                bottom: 20,
                left: null,
                width: 200,
                height: 200,
                circular: true,
                icon: Iconsax.camera,
                imageType: ImageType.asset,
                image: TImages.defaultImage,
              ),
              SizedBox(height: TSizes.spaceBtwItems,),
              Text('STORE',style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: TSizes.spaceBtwSections,),

            ],
          )
        ],
      ),
    );
  }
}
