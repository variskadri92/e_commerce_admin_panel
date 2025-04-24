import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/create_category/widgets/create_category_form.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateCategoryDesktop extends StatelessWidget {
  const CreateCategoryDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Categories',
                breadcrumbItems: [Routes.categories, 'Create Categories']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Form
            CreateCategoryForm(),
          ],
        ),
      ),
    ));
  }
}
