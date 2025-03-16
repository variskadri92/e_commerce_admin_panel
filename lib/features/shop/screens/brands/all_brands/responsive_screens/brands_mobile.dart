import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/brand/brand_controller.dart';
import '../table/brand_data_table.dart';

class BrandsMobile extends StatelessWidget {
  const BrandsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              BreadcrumbWithHeading(
                  heading: 'Brands', breadcrumbItems: ['Brands']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      buttonText: 'Create New Brand',
                      onPressed: () => Get.toNamed(Routes.createBrands),
                      searchController: controller.searchTextController,
                      searchOnChanged: (query)=> controller.searchQuery(query),

                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TLoaderAnimation();
                      }
                      return BrandDataTable();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
