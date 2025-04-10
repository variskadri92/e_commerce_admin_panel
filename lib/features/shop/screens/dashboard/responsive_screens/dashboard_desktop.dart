import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import '../table/dashboard_order_table.dart';
import '../widgets/dashboard_card.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

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
              ///Heading
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: TSizes.spaceBtwSections),

              ///Cards
              Row(
                children: [
                  Expanded(
                      child: Obx(
                    () => DashboardCard(
                      context: context,
                      headingIcon: Iconsax.note,
                      headingIconColor: Colors.blue,
                      headingIconBgColor: Colors.blue.withOpacity(0.1),
                      title: 'Sales total',
                      subtitle:
                          '₹${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                      stats: 25,
                    ),
                  )),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                      child: Obx(
                    () => DashboardCard(
                      context: context,
                      headingIcon: Iconsax.external_drive,
                      headingIconColor: Colors.green,
                      headingIconBgColor: Colors.green.withOpacity(0.1),
                      title: 'Average Order Value',
                      subtitle:
                          '₹${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                      stats: 15,
                    ),
                  )),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                      child: Obx(
                    () => DashboardCard(
                      context: context,
                      headingIcon: Iconsax.box,
                      headingIconColor: Colors.deepPurple,
                      headingIconBgColor: Colors.deepPurple.withOpacity(0.1),
                      title: 'Total Orders',
                      subtitle:
                          '${controller.orderController.allItems.length}',
                      stats: 44,
                    ),
                  )),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                      child: Obx(
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
                  )),
                ],
              ),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Graphs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
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
                              Text(
                                'Recent Orders',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(
                                height: TSizes.spaceBtwSections,
                              ),
                              DashboardOrderTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),

                  ///Pie Chart
                  Expanded(child: OrderStatusPieChart())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class MyData extends DataTableSource {
//   final controller = Get.put(DashboardController());
//
//   @override
//   DataRow? getRow(int index) {
//     final data = controller.filteredDataList[index];
//     return DataRow2(
//         onTap: () {},
//         selected: controller.selectedRows[index],
//         onSelectChanged: (value) =>
//             controller.selectedRows[index] = value ?? false,
//         cells: [
//           DataCell(Text(data['Column1'] ?? '')),
//           DataCell(Text(data['Column2'] ?? '')),
//           DataCell(Text(data['Column3'] ?? '')),
//           DataCell(Text(data['Column4'] ?? '')),
//         ]);
//   }
//
//   @override
//   bool get isRowCountApproximate => false;
//
//   @override
//   // TODO: implement rowCount
//   int get rowCount => controller.filteredDataList.length;
//
//   @override
//   // TODO: implement selectedRowCount
//   int get selectedRowCount => 0;
// }
