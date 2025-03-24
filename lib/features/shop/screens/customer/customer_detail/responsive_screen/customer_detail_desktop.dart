import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../controllers/customer/customer_detail_controller.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/shipping_address.dart';

class CustomerDetailDesktop extends StatelessWidget {
  const CustomerDetailDesktop({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;
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
                heading: customer.fullName,
                breadcrumbItems: [Routes.customers, 'Details']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Left Side Customer Information
                Expanded(
                  child: Column(
                    children: [
                      //Customer Info
                      CustomerInfo(
                        customer: customer,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      //Shipping Address
                      ShippingAddress(),
                    ],
                  ),
                ),

                SizedBox(
                  width: TSizes.spaceBtwSections,
                ),

                //Right Side Customer Order History
                Expanded(
                  flex: 2,
                  child: CustomerOrders(),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
