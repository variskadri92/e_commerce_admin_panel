import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../controllers/media_controller.dart';
import '../widgets/media_content.dart';
import '../widgets/media_uploader.dart';

class MediaDesktop extends StatelessWidget {
  const MediaDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Breadcrumbs
                  BreadcrumbWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [Routes.login, 'media Screen'],
                  ),

                  SizedBox(
                    width: TSizes.buttonWidth * 1.5,
                      child: ElevatedButton.icon(
                          onPressed: ()=> controller.showImagesUploaderSection.value = !controller.showImagesUploaderSection.value,
                          icon: Icon(Iconsax.cloud_add),
                          label: Text('Upload Images')))
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Upload Area
              MediaUploader(),

              ///Media
              MediaContent(allowSelection: false,allowMultipleSelection: false,),
            ],
          ),
        ),
      ),
    );
  }
}
