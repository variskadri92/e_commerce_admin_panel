import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_tablet.dart';

class EditBannersScreen extends StatelessWidget {
  const EditBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return SiteLayout(
      desktop: EditBannerDesktop(
        banner: banner,
      ),
      tablet: EditBannerTablet(banner: banner,),
      mobile: EditBannerMobile(banner: banner,),
    );
  }
}
