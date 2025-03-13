import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class EditBannerDesktop extends StatelessWidget {
  const EditBannerDesktop({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              BreadcrumbWithHeading(returnToPreviousScreen: true,heading: 'Update Banner', breadcrumbItems: [Routes.banners,'Update Banner']),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Form
              EditBannerForm(banner: banner,),


            ],
          ),),
      ),
    );
  }
}
