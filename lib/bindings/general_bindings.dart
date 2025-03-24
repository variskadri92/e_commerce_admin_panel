import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import '../features/authentication/controllers/user_controller.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {

    ///Core
    Get.lazyPut(()=>NetworkManager(),fenix: true);
    Get.lazyPut(()=>UserController(),fenix: true);
    Get.lazyPut(()=>SettingsController(),fenix: true);
  }

}