import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';

class RouteObserver extends GetObserver{

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());

    if(previousRoute != null){
      for(var routeName in Routes.sideBarMenuItems){
        if(previousRoute.settings.name == routeName){
          sidebarController.activeItem.value == routeName;
        }
      }
    }


  }

  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {

  }
}