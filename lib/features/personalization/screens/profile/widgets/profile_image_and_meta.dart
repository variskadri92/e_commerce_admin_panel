import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../authentication/controllers/user_controller.dart';

class ProfileImageAndMeta extends StatelessWidget {
  const ProfileImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return TRoundedContainer(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            ()=> Column(
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
                  loading: controller.loading.value,
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : TImages.user,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  controller.user.value.fullName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(controller.user.value.email),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
