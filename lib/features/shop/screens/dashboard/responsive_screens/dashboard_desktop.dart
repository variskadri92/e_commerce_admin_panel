import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../controllers/dashboard_controller.dart';
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
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        ///Bar Graph
                        TRoundedContainer(
                          child: Column(
                            children: [
                              Text(
                                'Weekly Sales',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(
                                height: TSizes.spaceBtwItems,
                              ),

                              //Graph
                              SizedBox(
                                height: 400,
                                child: BarChart(BarChartData(
                                    titlesData: buildFlTitlesData(),
                                    borderData: FlBorderData(
                                        show: true,
                                        border: Border(
                                            top: BorderSide.none,
                                            right: BorderSide.none)),
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      drawHorizontalLine: true,
                                      horizontalInterval: 200,
                                    ),
                                    barGroups: controller.weeklySales
                                        .asMap()
                                        .entries
                                        .map((entry) => BarChartGroupData(
                                                x: entry.key,
                                                barRods: [
                                                  BarChartRodData(
                                                    width: 30,
                                                    color: TColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            TSizes.sm),
                                                    toY: entry.value,
                                                  )
                                                ]))
                                        .toList(),
                                    groupsSpace: TSizes.spaceBtwItems,
                                    barTouchData: BarTouchData(
                                        touchTooltipData: BarTouchTooltipData(
                                            getTooltipColor: (_) =>
                                                TColors.secondary),
                                        touchCallback:
                                            TDeviceUtils.isDesktopScreen(
                                                    context)
                                                ? (barTouchEvent,
                                                    barTouchResponse) {}
                                                : null))),
                              ),
                            ],
                          ),
                        ),
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
                  Expanded(child: TRoundedContainer())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              //Map index to the desired day of week
              final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

              //Calculate the index and ensure it wraps around for the correct day
              final index = value.toInt() % days.length;

              //Get the day corresponding to the calculated index
              final day = days[index];

              return SideTitleWidget(
                meta: meta,
                space: 0,
                child: Text(day),
              ); //axisSide bottom depreciated
            }),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 200,
          reservedSize: 50,
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
