import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_tablet.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brands_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brands_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brands_tablet.dart';

class CreateBrandsScreen extends StatelessWidget {
  const CreateBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(desktop: CreateBrandsDesktop(),tablet: CreateBrandsTablet(),mobile: CreateBrandsMobile());
  }
}
