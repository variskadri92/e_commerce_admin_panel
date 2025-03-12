import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/brand_model.dart';
import '../widgets/edit_brand_form.dart';

class EditBrandsMobile extends StatelessWidget {
  const EditBrandsMobile({super.key, required this.brand});

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
              EditBrandForm(),


            ],
          ),),
      ),
    );
  }
}
