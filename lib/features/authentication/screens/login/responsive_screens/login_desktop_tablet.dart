import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/login_template.dart';


import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginDesktopTablet extends StatelessWidget {
  const LoginDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginTemplate(
      child: Column(
        children: [
          //Header
          LoginHeader(),

          //Form
          LoginForm(),
        ],
      ),
    );
  }
}
