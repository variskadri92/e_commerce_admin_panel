import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../personalization/models/user_model.dart';
import '../../../../controllers/customer/customer_detail_controller.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/shipping_address.dart';


class CustomerDetailMobile extends StatelessWidget {
  const CustomerDetailMobile({super.key, required this.customer});

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
                CustomerInfo(
                  customer: customer,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //Shipping Address
                ShippingAddress(),

                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Customer Order History
                CustomerOrders()
              ],
            ),
          ),
        ));
  }
}
