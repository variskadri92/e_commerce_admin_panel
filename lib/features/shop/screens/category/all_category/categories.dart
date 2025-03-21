import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/responsive_screens/category_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/responsive_screens/category_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/responsive_screens/category_tablet.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: const CategoryDesktop(),
      tablet: const CategoryTablet(),
      mobile: const CategoryMobile(),
    );
  }
}
