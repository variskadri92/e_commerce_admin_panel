import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/order_customer.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';
import '../../../../models/order_model.dart';

class OrderDetailMobile extends StatelessWidget {
  const OrderDetailMobile({super.key, required this.order});

  final OrderModel order;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Breadcrumbs
                BreadcrumbWithHeading(
                    returnToPreviousScreen: true,
                    heading: order.id,
                    breadcrumbItems: [Routes.orders, 'Details']),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Body
                OrderInfo(
                  order: order,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Items
                OrderItems(order :order),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Transaction
                OrderTransaction(order: order),

                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Right Side Customer Order History
                OrderCustomer(
                  order: order,
                ),
                SizedBox(height: TSizes.spaceBtwSections,)
              ],
            ),
          ),
        ));
  }
}
