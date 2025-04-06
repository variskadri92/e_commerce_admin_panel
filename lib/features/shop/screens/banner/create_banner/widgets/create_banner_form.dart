import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/banner/create_banner_controller.dart';
import 'package:yt_ecommerce_admin_panel/routes/app_screens.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.createBannerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            SizedBox(
              height: TSizes.sm,
            ),
            Text(
              'Create New Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Image Uploader & Featured Checkbox
            Column(
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: TRoundedImage(
                      width: 400,
                      height: 200,
                      image: controller.imageURL.value.isNotEmpty
                          ? controller.imageURL.value
                          : TImages.defaultImage,
                      imageType: controller.imageURL.value.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                    ),
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TextButton(
                    onPressed: () => controller.pickImage(),
                    child: Text('Select Image')),
              ],
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            Text(
              'Make your Banner Active or InActive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Obx(
              () => CheckboxMenuButton(
                  value: controller.isActive.value,
                  onChanged: (value) =>
                      controller.isActive.value = value ?? false,
                  child: Text('Active')),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            Obx(
              () => DropdownButton<String>(
                items: AppScreens.allAppScreenItems
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) =>
                    controller.targetScreen.value = newValue!,
                value: controller.targetScreen.value,
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=> controller.createBanner(),
                child: Text('Create'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
