import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/table/category_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/customer/all_customer/table/customer_data_table.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class CustomerDesktop extends StatelessWidget {
  const CustomerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(heading: 'Customers', breadcrumbItems: ['Customers']),
            const SizedBox(height: TSizes.spaceBtwSections,),

            //Table Body
            TRoundedContainer(
              child: Column(
                children: [
                  //Table Header
                  TableHeader(showLeftWidget: false,),

                  //Table
                  CustomerDataTable(),
                ],
              ),
            ),
          ],
        ),),
      )
    );
  }
}
