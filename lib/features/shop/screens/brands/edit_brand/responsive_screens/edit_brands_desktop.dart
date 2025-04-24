import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/edit_brand/widgets/edit_brand_form.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';

class EditBrandsDesktop extends StatelessWidget {
  const EditBrandsDesktop({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(returnToPreviousScreen: true,heading: 'Update Brands', breadcrumbItems: [Routes.brands,'Update Brands']),
            const SizedBox(height: TSizes.spaceBtwSections,),

            //Form
            EditBrandForm(brand: brand,),


          ],
        ),),
      ),
    );
  }
}
