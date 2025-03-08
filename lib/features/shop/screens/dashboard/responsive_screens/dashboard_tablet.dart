import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../table/dashboard_order_table.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardTablet extends StatelessWidget {
  const DashboardTablet({super.key});

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Expanded(child: DashboardCard(title: 'Sales total',subtitle: '\$120,000',stats: 25,)),
                  SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: DashboardCard(title: 'Average Order Value',subtitle: '\$120',stats: 15,)),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwItems,),

              Row(
                children: [
                  Expanded(child: DashboardCard(title: 'Total Orders',subtitle: '26',stats: 44,)),
                  SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: DashboardCard(title: 'Visitors',subtitle: '23,456',stats: 25,)),
                ],
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
