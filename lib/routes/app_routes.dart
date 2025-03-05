import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/dashboard/dashboard.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes_middleware.dart';
import '../features/authentication/screens/login/login.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      //middlewares: [RoutesMiddleware()],
    ),GetPage(
      name: Routes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
      transition: Transition.fadeIn,
      //middlewares: [RoutesMiddleware()],
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPasswordScreen(),
      transition: Transition.fadeIn,
      //middlewares: [RoutesMiddleware()],
    ),GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),
  ];
}
