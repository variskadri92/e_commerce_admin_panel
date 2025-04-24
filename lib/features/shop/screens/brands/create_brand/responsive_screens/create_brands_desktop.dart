import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/create_brand/widgets/create_brand_form.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';

class CreateBrandsDesktop extends StatelessWidget {
  const CreateBrandsDesktop({super.key});

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
                  heading: 'Create Brands',
                  breadcrumbItems: [Routes.brands, 'Create Brands']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Form
              CreateBrandForm(),
            ],
          ),
        ),
      ),
    );
  }
}
