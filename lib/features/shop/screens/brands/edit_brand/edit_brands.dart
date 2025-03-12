import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brands_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brands_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brands_tablet.dart';

import '../../../models/brand_model.dart';

class EditBrandsScreen extends StatelessWidget {
  const EditBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = BrandModel(id: '',name: '',image: '');
    return SiteLayout(
        desktop: EditBrandsDesktop(brand: brand,),
        tablet: EditBrandsTablet(brand: brand,),
        mobile: EditBrandsMobile(brand: brand,));
  }
}
