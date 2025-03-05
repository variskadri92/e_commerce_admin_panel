import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import '../features/authentication/screens/login/login.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      //middlewares: [RoutesMiddleware()],
    ),


  ];
}