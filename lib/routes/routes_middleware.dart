import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';

class RoutesMiddleware  extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route) {

    print('==========================');
    final isAuthenticated = false;
    return isAuthenticated ? null : const RouteSettings(name: Routes.login);

  }
}