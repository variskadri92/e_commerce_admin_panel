import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../models/image_model.dart';

class ViewImagePopup extends StatelessWidget {
  const ViewImagePopup({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        //Define shape of dialog
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: TRoundedContainer(
          //Set the width of rounded container based on screen size
          width: TDeviceUtils.isDesktopScreen(context)
              ? MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          padding: EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //Display the image with an option to close dialog
              SizedBox(
                child: Stack(
                  children: [
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: TDeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.of(context).size.width * 0.4
                            : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Iconsax.close_circle))),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image Name : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        image.filename,
                        style: Theme.of(context).textTheme.titleLarge,
                      ))
                ],
              ),

              //Display the image url with option to copy it
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image URL : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        image.url,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url).then((value) =>
                            TLoaders.customToast(message: 'URL Copied!'));
                      },
                      child: Text('Copy URL'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Display a button to delete the image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                        onPressed: ()=> MediaController.instance.removeCloudImageConfirmation(image),
                        child: Text(
                          'Delete Image',
                          style: TextStyle(color: Colors.red),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
