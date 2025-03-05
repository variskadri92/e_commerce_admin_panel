import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

//Firebase auth instance
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  bool get isAuth => authUser != null;

  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
  }



  ///Login

  ///Register
  ///Register user by admin
  ///email verification
  ///forgot password
  ///re auth user
  ///logout user
  ///delete user
}
