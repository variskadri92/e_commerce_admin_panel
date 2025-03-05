import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ResetPasswordWidget(),),
      ),
    );
  }
}
