import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_tablet.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../models/category_model.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = CategoryModel(id: '',name: '',image: '');
    return SiteLayout(
      desktop: EditCategoryDesktop(category: category,),
      tablet: EditCategoryTablet(category: category,),
      mobile: EditCategoryMobile(category: category,),
    );
  }
}
