import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart%20%20';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController{

  static ForgetPasswordController get instance => Get.find();

  //variable
 final email = TextEditingController();
 GlobalKey<FormState> key = GlobalKey<FormState>();

 final isResendButtonOn = true.obs;
 final countdown=0.obs;
 Timer? _timer;

  //send reset password
void sendPasswordResetEmail()async {
  try{
    //Start Loading
    TFullScreenLoader.openLoadingDialog(
        'Processing your Request...', TImages.docerAnimation);


    //Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    //Form Validation
    if(!key.currentState!.validate()){
      TFullScreenLoader.stopLoading();
      return;
    }

    await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

    //Remove Loader
    TFullScreenLoader.stopLoading();

    //Show success message
    TLoaders.successSnackBar(title: 'Email Sent!',message: 'Email Link Sent to reset your password');

    Get.toNamed(Routes.resetPassword,parameters: {'email':email.text});
  }catch(e){
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: 'Oh Bad!', message: e.toString());
  }

}
  //resend reset password

  void resendPasswordResetEmail() async {
    await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
    TLoaders.successSnackBar(title: 'Email Sent!',message: 'Email Link Sent to reset your password');
    setCountdown();



  }

  void setCountdown(){
    isResendButtonOn.value = false;
    countdown.value = 30; // 30 seconds

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
        isResendButtonOn.value = true;
      }
    });
}}