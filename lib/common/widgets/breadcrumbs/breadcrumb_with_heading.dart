import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/texts/page_heading.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class BreadcrumbWithHeading extends StatelessWidget {
  const BreadcrumbWithHeading(
      {super.key,
      required this.heading,
      required this.breadcrumbItems,
      this.returnToPreviousScreen = false});

  // The heading of the page
  final String heading;

  // List of breadcrumbs items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Breadcrumb trail
        Row(
          children: [
            //Dashboard link
            InkWell(
              onTap: () => Get.offAllNamed(Routes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontWeightDelta: -1),
                ),
              ),
            ),


            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  Text('/'), // Separator between breadcrumb items
                  InkWell(
                    //Last item in the breadcrumb trail should not be clickable
                    onTap:  i == breadcrumbItems.length - 1
                        ? null
                        : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.xs),
                      //Format breadcrumb item : capitalize and remove '/'

                      child: Text(
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontWeightDelta: -1),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),

        SizedBox(
          height: TSizes.sm,
        ),

        //Heading of the page
        Row(
          children: [
            if (returnToPreviousScreen)
              IconButton(
                  onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            if (returnToPreviousScreen)
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
            TPageHeading(heading: heading),
          ],
        )
      ],
    );
  }

  // Helper function to capitalize the first letter of a string
  String capitalize(String s) {

    return s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';
  }
}
