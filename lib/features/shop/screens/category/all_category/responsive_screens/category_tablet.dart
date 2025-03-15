import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/table/category_data_table.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/category/category_controller.dart';

class CategoryTablet extends StatelessWidget {
  const CategoryTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breadcrumbs
            BreadcrumbWithHeading(
                heading: 'Categories', breadcrumbItems: ['Categories']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Table Body
            TRoundedContainer(
              child: Column(
                children: [
                  //Table Header
                  TableHeader(
                    buttonText: 'Create New Category',
                    onPressed: () => Get.toNamed(Routes.createCategories),
                    searchController: controller.searchTextController,
                    searchOnChanged: (query)=> controller.searchQuery(query),

                  ),

                  //Table
                  Obx(() {
                    if (controller.isLoading.value) return TLoaderAnimation();
                    return CategoryDataTable();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
