import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_additional_images.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_attributes.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_bottom_navigation_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_brand.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_categories.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_stock_and_pricing.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_thumbnail_image.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_type_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_variations.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/widgets/edit_product_visibilty.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/product_model.dart';
import '../widgets/edit_product_title_and_description.dart';


class EditProductMobile extends StatelessWidget {
  const EditProductMobile({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: EditProductBottomNavigationWidget(product: product),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Basic info
                  EditProductTitleAndDescription(),
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
                          EditProductTypeWidget(),
                          SizedBox(
                            height: TSizes.spaceBtwInputFields,
                          ),

                          //Stock
                          EditProductStockAndPricing(),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          //Attributes
                          EditProductAttributes(),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //Variations
                  EditProductVariations(),
                ],
              ),
              SizedBox(
                height: TSizes.defaultSpace,
              ),

              //Side
              EditProductThumbnailImage(),
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
                    EditProductAdditionallllImages(),
                  ],
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Product Brand
              EditProductBrand(),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Product Categories
              EditProductCategories(product: product,),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Product Visibility
              EditProductVisibility(),
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
