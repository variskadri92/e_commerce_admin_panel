import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:yt_ecommerce_admin_panel/features/media/screens/media/media.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/brands.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/create_brand/create_brands.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/edit_brand/edit_brands.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/categories.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/create_category/create_category.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/edit_category/edit_category.dart';
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
    GetPage(
      name: Routes.media,
      page: () => const MediaScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),

    //Categories
    GetPage(
      name: Routes.categories,
      page: () => const CategoriesScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),GetPage(
      name: Routes.createCategories,
      page: () => const CreateCategoryScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),GetPage(
      name: Routes.editCategories,
      page: () => const EditCategoryScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),


    //Brands
    GetPage(
      name: Routes.brands,
      page: () => const BrandsScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),GetPage(
      name: Routes.createBrands,
      page: () => const CreateBrandsScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),GetPage(
      name: Routes.editBrands,
      page: () => const EditBrandsScreen(),
      transition: Transition.fadeIn,
      middlewares: [RoutesMiddleware()],
    ),
  ];
}
