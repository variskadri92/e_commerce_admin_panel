import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

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
              DashboardCard(title: 'Sales total',subtitle: '\$120,000',stats: 25,),
              SizedBox(height: TSizes.spaceBtwItems,),
              DashboardCard(title: 'Average Order Value',subtitle: '\$120',stats: 15,),
              SizedBox(height: TSizes.spaceBtwItems,),
              DashboardCard(title: 'Total Orders',subtitle: '26',stats: 44,),
              SizedBox(height: TSizes.spaceBtwItems,),
              DashboardCard(title: 'Visitors',subtitle: '23,456',stats: 25,),


              SizedBox(height: TSizes.spaceBtwSections,),

              ///Bar Graph
              WeeklySalesGraph(),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Orders
              TRoundedContainer(),

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
