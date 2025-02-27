import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ResponsiveWidget extends StatelessWidget {
  const
  ResponsiveWidget({super.key, required this.desktop, required this.tablet, required this.mobile});

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_,constraints){
      if(constraints.maxWidth >= TSizes.desktopScreenSize){
        return desktop;
      }else if(constraints.maxWidth < TSizes.desktopScreenSize && constraints.maxWidth >= TSizes.tabletScreenSize){
        return tablet;
      }else{
        return mobile;
      }
    });
  }
}
