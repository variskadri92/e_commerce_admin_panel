import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
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
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
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
                            onCreated: (ctrl) =>
                                controller.dropzoneController = ctrl,
                            onDropInvalid: (ev) => print('Invalid file: $ev'),
                            onDropFiles: (ev) async {
                              print('Dropped multiple files : $ev');
                            },
                            onDropFile: (file) async {
                              final bytes = await controller
                                  .dropzoneController
                                  .getFileData(file);
                              final mimeType = await controller.dropzoneController.getFileMIME(file);
                              final filename = await controller.dropzoneController.getFilename(file);
                              final image = ImageModel(
                                  url: '',
                                  folder: '',
                                  filename: filename,
                                  contentType: mimeType,
                                  localImageToDisplay:
                                  Uint8List.fromList(bytes));
                              controller.selectedImagesToUpload.add(image);
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
                                  onPressed: () =>
                                      controller.selectLocalImages(),
                                  child: Text('Select Images'))
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
                if (controller.selectedImagesToUpload.isNotEmpty)
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
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
                                TextButton(
                                    onPressed: ()=> controller.selectedImagesToUpload.clear(),
                                    child: Text('Remove All')),
                                SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                TDeviceUtils.isMobileScreen(context)
                                    ? SizedBox.shrink()
                                    : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                            onPressed: ()=> controller.uploadImageConfirmation(),
                                            child: Text('Upload')))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: TSizes.spaceBtwItems / 2,
                          runSpacing: TSizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload
                              .where(
                                  (image) => image.localImageToDisplay != null)
                              .map((element) => TRoundedImage(
                                    height: 90,
                                    width: 90,
                                    padding: TSizes.sm,
                                    imageType: ImageType.memory,
                                    memoryImage: element.localImageToDisplay,
                                    backgroundColor: TColors.primaryBackground,
                                  ))
                              .toList(),
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        TDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () =>controller.uploadImageConfirmation(), child: Text('Upload')))
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )
          : SizedBox.shrink(),
    );
  }
}
