import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_tablet.dart';

class EditBannersScreen extends StatelessWidget {
  const EditBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(desktop: EditBannerDesktop(),tablet: EditBannerTablet(),mobile: EditBannerMobile(),);
  }
}
