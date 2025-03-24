import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/order/all_orders/table/order_data_table.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/order/order_controller.dart';

class OrdersDesktop extends StatelessWidget {
  const OrdersDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(
                heading: 'Orders', breadcrumbItems: ['Orders']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Table Body
            TRoundedContainer(
              child: Column(
                children: [
                  //Table Header
                  TableHeader(
                    showLeftWidget: false,
                    searchOnChanged: (query)=> controller.searchQuery(query),
                    searchController: controller.searchTextController,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  //Table
                  Obx(() {
                    if (controller.isLoading.value) {
                      return TLoaderAnimation();
                    }

                    return OrderDataTable();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
