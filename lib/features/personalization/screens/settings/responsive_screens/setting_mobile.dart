import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/settings_form.dart';
import '../widgets/settings_image_and_meta.dart';

class SettingMobile extends StatelessWidget {
  const SettingMobile({super.key});

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Profile Image and Meta
                    Expanded(child: SettingsImageAndMeta()),
                    SizedBox(
                      width: TSizes.spaceBtwSections,
                    ),

                    //Form
                    Expanded(flex: 2, child: SettingsForm()),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
