import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/coupon/create_coupon/responsive_screens/create_coupon_desktop.dart';

class CreateCouponScreen extends StatelessWidget {
  const CreateCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(desktop: CreateCouponDesktop(),);
  }
}
