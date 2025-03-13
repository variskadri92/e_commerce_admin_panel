import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../widgets/additional_images.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/thumbnail_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';

class CreateProductMobile extends StatelessWidget {
  const CreateProductMobile({super.key});

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
                  heading: 'Create Product',
                  breadcrumbItems: [Routes.products, 'Create Product']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Create Product
              Column(
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
              ),
              SizedBox(
                height: TSizes.defaultSpace,
              ),

              //Side
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
