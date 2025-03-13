import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/banner_model.dart';
import '../widgets/edit_banner_form.dart';

class EditBannerTablet extends StatelessWidget {
  const EditBannerTablet({super.key, required this.banner});

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
