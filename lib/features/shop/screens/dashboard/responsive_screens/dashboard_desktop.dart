import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: DashboardCard(
                    title: 'Sales total',
                    subtitle: '\$120,000',
                    stats: 25,
                  )),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                      child: DashboardCard(
                    title: 'Average Order Value',
                    subtitle: '\$120',
                    stats: 15,
                  )),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                      child: DashboardCard(
                    title: 'Total Orders',
                    subtitle: '26',
                    stats: 44,
                  )),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                      child: DashboardCard(
                    title: 'Visitors',
                    subtitle: '23,456',
                    stats: 25,
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
                        TRoundedContainer(),
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
