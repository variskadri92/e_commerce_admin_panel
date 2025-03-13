import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/create_product/responsive_screens/create_product_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/create_product/responsive_screens/create_product_mobile.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(desktop: CreateProductDesktop(),mobile: CreateProductMobile(),);
  }
}
