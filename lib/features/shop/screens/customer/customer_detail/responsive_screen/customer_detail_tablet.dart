import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../personalization/models/user_model.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/shipping_address.dart';

class CustomerDetailTablet extends StatelessWidget {
  const CustomerDetailTablet({super.key, required this.customer});

  final UserModel customer;

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
