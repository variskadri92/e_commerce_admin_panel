import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/headers/header.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/responsive_design.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/screens/tablet_layout.dart';

class SiteLayout extends StatelessWidget {
  const SiteLayout(
      {super.key,
      this.desktop,
      this.tablet,
      this.mobile,
      this.useLayout = true});

  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;

  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: Header(),
      body: ResponsiveWidget(
        desktop: useLayout
            ? DesktopLayout(
                body: desktop,
              )
            : desktop ?? SizedBox(),
        tablet: useLayout
            ? TabletLayout(
                body: tablet ?? desktop,
              )
            : tablet ?? desktop ?? SizedBox(),
        mobile: useLayout
            ? MobileLayout(
                body: mobile ?? desktop,
              )
            : mobile ?? desktop ?? SizedBox(),
      ),
    );
  }
}
