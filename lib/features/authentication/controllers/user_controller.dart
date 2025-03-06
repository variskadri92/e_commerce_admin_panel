import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  ///Obs variable
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final userRepository = Get.put(UserRepository());

  ///Fetch user details from repository
  Future<UserModel> fetchUserDetails()async{
    try{
      final user = await userRepository.fetchAdminDetails();
      return user;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }
}