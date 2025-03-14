import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/settings/responsive_screens/setting_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/settings/responsive_screens/setting_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/settings/responsive_screens/setting_tablet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: SettingDesktop(),
      mobile: SettingMobile(),
      tablet: SettingTablet(),
    );
  }
}
