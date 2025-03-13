import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/additional_images.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/brand_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/categories_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/product_type_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/stock_pricing_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/thumbnail_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/title_description.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/variations_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/Edit_product/widgets/visibility_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/attributes_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/bottom_navigation_widget.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';


class EditProductDesktop extends StatelessWidget {
  const EditProductDesktop({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Breadcrumbs
              BreadcrumbWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Edit Product',
                  breadcrumbItems: [Routes.products, 'Edit Product']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Edit Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Basic info
                          ProductTitleAndDescription(),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          //Stock and Pricing
                          TRoundedContainer(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Heading
                                  Text(
                                    'Stock & Pricing',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  SizedBox(
                                    height: TSizes.spaceBtwItems,
                                  ),

                                  //Product Type
                                  ProductTypeWidget(),
                                  SizedBox(
                                    height: TSizes.spaceBtwInputFields,
                                  ),

                                  //Stock
                                  ProductStockAndPricing(),
                                  SizedBox(
                                    height: TSizes.spaceBtwSections,
                                  ),

                                  //Attributes
                                  ProductAttributes(),
                                  SizedBox(
                                    height: TSizes.spaceBtwSections,
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          //Variations
                          ProductVariations(),
                        ],
                      )),
                  SizedBox(
                    width: TSizes.defaultSpace,
                  ),

                  //Side
                  Expanded(
                      child: Column(
                    children: [
                      //Product Thumbnail
                      ProductThumbnailImage(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      //Product Images
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Product Images',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            ProductAdditionalImages(
                              additionalProductImagesURLs: RxList.empty(),
                              onTapToAddImages: () {},
                              onTapToRemoveImages: (index) {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      //Product Brand
                      ProductBrand(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      //Product Categories
                      ProductCategories(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      //Product Visibility
                      ProductVisibilityWidget(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                    ],
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
