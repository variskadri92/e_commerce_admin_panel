import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart%20%20';

///Controller to manage Media Operations
class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneController;
}
