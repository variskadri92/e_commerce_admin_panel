import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/customer/customer_detail/responsive_screen/customer_detail_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/customer/customer_detail/responsive_screen/customer_detail_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/customer/customer_detail/responsive_screen/customer_detail_tablet.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments ;
    return SiteLayout(
      desktop: CustomerDetailDesktop(customer: customer,),
      tablet: CustomerDetailTablet(customer: customer,),
      mobile: CustomerDetailMobile(customer: customer,),
    );
  }
}
