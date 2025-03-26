import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../table/dashboard_order_table.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: TSizes.spaceBtwSections),

              //Cards
              Obx(
                    () => DashboardCard(
                  context: context,
                  headingIcon: Iconsax.note,
                  headingIconColor: Colors.blue,
                  headingIconBgColor: Colors.blue.withOpacity(0.1),
                  title: 'Sales total',
                  subtitle:
                  '\$${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                  stats: 25,
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                    () => DashboardCard(
                  context: context,
                  headingIcon: Iconsax.external_drive,
                  headingIconColor: Colors.green,
                  headingIconBgColor: Colors.green.withOpacity(0.1),
                  title: 'Average Order Value',
                  subtitle:
                  '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                  stats: 15,
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                    () => DashboardCard(
                  context: context,
                  headingIcon: Iconsax.box,
                  headingIconColor: Colors.deepPurple,
                  headingIconBgColor: Colors.deepPurple.withOpacity(0.1),
                  title: 'Total Orders',
                  subtitle:
                  '\$${controller.orderController.allItems.length}',
                  stats: 44,
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                    () => DashboardCard(
                  context: context,
                  headingIcon: Iconsax.user,
                  headingIconColor: Colors.deepOrange,
                  headingIconBgColor: Colors.deepOrange.withOpacity(0.1),
                  title: 'Visitors',
                  subtitle: controller.customerController.allItems.length
                      .toString(),
                  stats: 25,
                ),
              ),


              SizedBox(height: TSizes.spaceBtwSections,),

              ///Bar Graph
              WeeklySalesGraph(),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Orders
              TRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall,),
                    SizedBox(height: TSizes.spaceBtwSections,),
                    DashboardOrderTable(),
                  ],
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Pie Chart
              OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
