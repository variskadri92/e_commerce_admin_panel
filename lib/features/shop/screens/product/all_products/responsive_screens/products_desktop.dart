import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/table/category_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/all_products/table/products_data_table.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductsDesktop extends StatelessWidget {
  const ProductsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(heading: 'Products', breadcrumbItems: ['Products']),
            const SizedBox(height: TSizes.spaceBtwSections,),

            //Table Body
            TRoundedContainer(
              child: Column(
                children: [
                  //Table Header
                  TableHeader(buttonText: 'Add Products',onPressed: ()=> Get.toNamed(Routes.createProducts),),

                  //Table
                  ProductsDataTable(),
                ],
              ),
            ),
          ],
        ),),
      )
    );
  }
}
