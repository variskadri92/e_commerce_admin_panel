import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class WeeklySalesGraph extends StatelessWidget {
  const WeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return TRoundedContainer(
      child: Column(
        children: [
          Text(
            'Weekly Sales',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Graph
          SizedBox(
            height: 415,
            child: BarChart(BarChartData(
                titlesData: buildFlTitlesData(controller.weeklySales),
                borderData: FlBorderData(
                    show: true,
                    border:
                        Border(top: BorderSide.none, right: BorderSide.none)),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: true,
                  horizontalInterval: 200,
                ),
                barGroups: controller.weeklySales
                    .asMap()
                    .entries
                    .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                          BarChartRodData(
                            width: 30,
                            color: TColors.primary,
                            borderRadius: BorderRadius.circular(TSizes.sm),
                            toY: entry.value,
                          )
                        ]))
                    .toList(),
                groupsSpace: TSizes.spaceBtwItems,
                barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => TColors.secondary),
                    touchCallback: TDeviceUtils.isDesktopScreen(context)
                        ? (barTouchEvent, barTouchResponse) {}
                        : null))),
          ),
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData(List<double> weeklySales) {
  //Calculate Step height for the left pricing
  double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b);
  double stepHeight = (maxOrder/10).ceilToDouble();
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
        interval: stepHeight,
        reservedSize: 50,
      ),
    ),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
