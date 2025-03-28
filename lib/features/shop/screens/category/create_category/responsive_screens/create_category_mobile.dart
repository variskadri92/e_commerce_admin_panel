import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/create_category_form.dart';

class CreateCategoryMobile extends StatelessWidget {
  const CreateCategoryMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Breadcrumbs
                BreadcrumbWithHeading(returnToPreviousScreen: true,heading: 'Create Categories', breadcrumbItems: [Routes.categories,'Create Categories']),
                const SizedBox(height: TSizes.spaceBtwSections,),

                //Form
                CreateCategoryForm(),


              ],
            ),),
        )
    );
  }
}
