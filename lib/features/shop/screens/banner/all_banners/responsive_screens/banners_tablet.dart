import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/banner/all_banners/table/banner_data_table.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/banner/banner_controller.dart';
class BannersTablet extends StatelessWidget {
  const BannersTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              BreadcrumbWithHeading(heading: 'Banners', breadcrumbItems: ['Banners']),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Table Body
              Obx(
                    () {
                  if (controller.isLoading.value) {
                    return const TLoaderAnimation();
                  }
                  return TRoundedContainer(
                    child: Column(
                      children: [
                        TableHeader(
                          buttonText: 'Create New Banner',
                          onPressed: () => Get.toNamed(Routes.createBanners),
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        BannerDataTable(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),),
      ),
    );
  }
}
