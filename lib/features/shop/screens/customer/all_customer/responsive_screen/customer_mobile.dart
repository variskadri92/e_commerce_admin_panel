import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/customer/customer_controller.dart';
import '../table/customer_data_table.dart';

class CustomerMobile extends StatelessWidget {
  const CustomerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());

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
                      TableHeader(showLeftWidget: false,
                        searchController: controller.searchTextController,
                        searchOnChanged: (query)=> controller.searchQuery(query),),

                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      //Table
                      Obx(() {
                        if(controller.isLoading.value) return TLoaderAnimation();

                        return CustomerDataTable();
                      }),
                    ],
                  ),
                ),
              ],
            ),),
        )
    );
  }
}
