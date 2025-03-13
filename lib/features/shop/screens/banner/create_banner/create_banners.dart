import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/create_banner/responsive_screens/create_banner_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/create_banner/responsive_screens/create_banner_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/create_banner/responsive_screens/create_banner_tablet.dart';

class CreateBannersScreen extends StatelessWidget {
  const CreateBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(desktop: CreateBannerDesktop(),tablet: CreateBannerTablet(),mobile: CreateBannerMobile(),);
  }
}
