import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/settings_controller.dart';

class SettingsImageAndMeta extends StatelessWidget {
  const SettingsImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return TRoundedContainer(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              //User Image
              Obx(
                ()=> TImageUploader(
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.loading.value,
                  imageType: controller.settings.value.appLogo.isNotEmpty?ImageType.network: ImageType.asset,
                  image:controller.settings.value.appLogo.isNotEmpty? controller.settings.value.appLogo : TImages.defaultImage,
                  onIconButtonPressed: ()=> controller.updateAppLogo(),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems,),
              Text(controller.settings.value.appName,style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: TSizes.spaceBtwSections,),

            ],
          )
        ],
      ),
    );
  }
}
