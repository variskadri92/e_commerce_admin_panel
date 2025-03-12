import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/table/data_table.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';

class BrandsDesktop extends StatelessWidget {
  const BrandsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(heading: 'Brands', breadcrumbItems: ['Brands']),
            const SizedBox(height: TSizes.spaceBtwSections,),

            //Table Body
            TRoundedContainer(
              child: Column(
                children: [
                  TableHeader(buttonText: 'Create New Brand',onPressed: ()=> Get.toNamed(Routes.createBrands),),
                  SizedBox(height: TSizes.spaceBtwItems,),

                  BrandDataTable(),


                ],
              ),
            )
          ],
        ),),
      ),
    );
  }
}
