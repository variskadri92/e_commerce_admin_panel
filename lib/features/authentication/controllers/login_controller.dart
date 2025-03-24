import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/setting_model.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

import '../../../data/repositories/settings/settings_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/helpers/network_manager.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///variable
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  @override
  void onInit() {
    email.text =
        localStorage.read('REMEMBER_ME_EMAIL') ?? 'yashgotrijiya@gmail.com';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? 'admin@123';
    super.onInit();
  }

  ///Handles email and password login
  Future<void> emailAndPasswordSignIn() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging into your account', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Validate Form
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      ///Save data if remember me
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      /// login user
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      ///Fetch user details and assign to user controller
      final user = await UserController.instance.fetchUserDetails();

      TFullScreenLoader.stopLoading();

      //If user is not admin logout and return
      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(
            title: 'Not Authorized', message: 'You are not an admin.');
      } else {
        AuthenticationRepository.instance.screenRedirect();
      }

      //Show success message
      TLoaders.successSnackBar(
          title: 'Congratulations!',
          message: 'You have been Logged in successfully.');

      //Move to Screen
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Bad!', message: e.toString());
    }
  }

  ///Handles registration of admin user
  Future<void> registerAdmin() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Registering Admin Account...', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Register user with email and password
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      //Create admin record in Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          fullName: 'Admin',
          email: email.text.trim(),
          role: AppRole.admin,
          createdAt: DateTime.now()));

      //Create Settings record in Firestore
      final settingsRepository = Get.put(SettingsRepository());
      await settingsRepository.registerSettings(SettingsModel(
        appLogo: '',
        appName: 'My App',
        taxRate: 0,
        shippingCost: 0,
      ));

      //Stop Loading
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
