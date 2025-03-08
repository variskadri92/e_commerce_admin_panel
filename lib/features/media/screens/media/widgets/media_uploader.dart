import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/media/screens/media/widgets/media_folder_dropdown.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Column(
      children: [
        ///Drag and Drop Area
        TRoundedContainer(
          showBorder: true,
          height: 250,
          borderColor: TColors.borderPrimary,
          backgroundColor: TColors.primaryBackground,
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Expanded(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  DropzoneView(
                    mime: ['image/jpeg', 'image/png'],
                    cursor: CursorType.Default,
                    operation: DragOperation.copy,
                    onLoaded: () => print('Loaded'),
                    onError: (ev) => print('Error: $ev'),
                    onHover: () => print('Hovering'),
                    onLeave: () => print('Leaving'),
                    onCreated: (ctrl) => controller.dropzoneController = ctrl,
                    onDrop: (file) => print('Dropped file: $file'),
                    onDropInvalid: (ev) => print('Invalid file: $ev'),
                    onDropMultiple: (ev) async {
                      print('Dropped multiple files : $ev');
                    },
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        TImages.defaultMultiImageIcon,
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Text('Drag and Drop Images here'),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: Text('Select Images'))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),

        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        ///Locally Selected Images
        TRoundedContainer(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Folders Dropdown
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
                          }
                        },
                      ),
                    ],
                  ),

                  ///Upload & Remove button
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: Text('Remove All')),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      TDeviceUtils.isMobileScreen(context)
                          ? SizedBox.shrink()
                          : SizedBox(
                              width: TSizes.buttonWidth,
                              child: ElevatedButton(
                                  onPressed: () {}, child: Text('Upload')))
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
