import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/table/data_table.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class CategoryTablet extends StatelessWidget {
  const CategoryTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Breadcrumbs
                BreadcrumbWithHeading(heading: 'Categories', breadcrumbItems: ['Categories']),
                const SizedBox(height: TSizes.spaceBtwSections,),

                //Table Body
                TRoundedContainer(
                  child: Column(
                    children: [
                      //Table Header
                      TableHeader(buttonText: 'Create New Category',onPressed: ()=> Get.toNamed(Routes.createCategories),),

                      //Table
                      CategoryDataTable(),
                    ],
                  ),
                ),
              ],
            ),),
        )
    );
  }
}
