import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/brand_data_table.dart';

class BrandsTablet extends StatelessWidget {
  const BrandsTablet({super.key});

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
