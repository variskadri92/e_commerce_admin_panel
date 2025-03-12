import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../models/category_model.dart';
import '../widgets/edit_category_form.dart';
class EditCategoryDesktop extends StatelessWidget {
  const EditCategoryDesktop({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(returnToPreviousScreen: true,heading: 'Update Categories', breadcrumbItems: [Routes.categories,'Update Categories']),
            const SizedBox(height: TSizes.spaceBtwSections,),
        
            //Form
            EditCategoryForm(category: category),
          ]
        ),),
      ),
    );
  }
}
