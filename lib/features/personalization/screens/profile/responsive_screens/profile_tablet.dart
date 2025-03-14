import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/image_and_meta.dart';
import '../widgets/profile_form.dart';

class ProfileTablet extends StatelessWidget {
  const ProfileTablet({super.key});

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
                    heading: 'Profile', breadcrumbItems: ['Profile']),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Body
                ImageAndMeta(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Form
                ProfileForm()
              ],
            ),
          ),
        ));
  }
}
