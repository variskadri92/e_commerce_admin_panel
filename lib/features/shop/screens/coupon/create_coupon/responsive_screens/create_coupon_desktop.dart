import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/coupon/create_coupon/widget/create_coupon_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateCouponDesktop extends StatelessWidget {
  const CreateCouponDesktop({super.key});

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
                  heading: 'Create Coupon',
                  breadcrumbItems: [Routes.coupons, 'Create Coupon']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Form
              CreateCouponForm(),
            ],
          ),
        ),
      ),
    );
  }
}
