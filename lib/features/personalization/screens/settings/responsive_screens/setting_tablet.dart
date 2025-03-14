import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/settings_form.dart';
import '../widgets/settings_image_and_meta.dart';

class SettingTablet extends StatelessWidget {
  const SettingTablet({super.key});

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
                    heading: 'Settings', breadcrumbItems: ['Settings']),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Body
                SettingsImageAndMeta(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Form
                SettingsForm()
              ],
            ),
          ),
        ));
  }
}
