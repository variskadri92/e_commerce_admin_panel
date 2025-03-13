import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/create_banner/widgets/create_banner_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateBannerDesktop extends StatelessWidget {
  const CreateBannerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              BreadcrumbWithHeading(returnToPreviousScreen: true,heading: 'Create Banner', breadcrumbItems: [Routes.banners,'Create Banner']),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Form
              CreateBannerForm(),


            ],
          ),),
      ),
    );
  }
}
