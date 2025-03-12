import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_tablet.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(desktop: const BrandsDesktop(),tablet: const BrandsTablet(),mobile: const BrandsMobile());
  }
}
