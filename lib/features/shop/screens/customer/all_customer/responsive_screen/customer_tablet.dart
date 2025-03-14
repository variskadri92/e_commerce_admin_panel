import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/customer_data_table.dart';

class CustomerTablet extends StatelessWidget {
  const CustomerTablet({super.key});

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
