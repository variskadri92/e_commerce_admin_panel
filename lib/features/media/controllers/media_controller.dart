import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';

///Controller to manage Media Operations
class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;

  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;
}
