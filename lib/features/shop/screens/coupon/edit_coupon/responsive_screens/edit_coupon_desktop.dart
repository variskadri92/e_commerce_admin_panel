import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/coupon_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/coupon/edit_coupon/widget/edit_coupon_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class EditCouponDesktop extends StatelessWidget {
  const EditCouponDesktop({super.key, required this.coupon});

  final CouponModel coupon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Breadcrumbs
                BreadcrumbWithHeading(returnToPreviousScreen: true,heading: 'Update Coupon', breadcrumbItems: [Routes.coupons,'Update Coupon']),
                const SizedBox(height: TSizes.spaceBtwSections,),

                //Form
                EditCouponForm(coupon: coupon),
              ]
          ),),
      ),
    );;
  }
}
