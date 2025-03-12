import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/create_brand_form.dart';

class CreateBrandsTablet extends StatelessWidget {
  const CreateBrandsTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              BreadcrumbWithHeading(returnToPreviousScreen: true,heading: 'Create Brands', breadcrumbItems: [Routes.brands,'Create Brands']),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Form
              CreateBrandForm(),


            ],
          ),),
      ),
    );
  }
}
