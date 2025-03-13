import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/create_product/widgets/product_type_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/create_product/widgets/stock_pricing_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/create_product/widgets/title_description.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../widgets/attributes_widget.dart';

class CreateProductDesktop extends StatelessWidget {
  const CreateProductDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: ,
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
                          SizedBox(height: TSizes.spaceBtwSections,),

                          //Stock and Pricing
                          TRoundedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Heading
                                Text('Stock & Pricing',style: Theme.of(context).textTheme.headlineSmall,),
                                SizedBox(height: TSizes.spaceBtwItems,),

                                //Product Type
                                ProductTypeWidget(),
                                SizedBox(height: TSizes.spaceBtwInputFields,),

                                //Stock
                                ProductStockAndPricing(),
                                SizedBox(height: TSizes.spaceBtwSections,),

                                //Attributes
                                ProductAttributes(),
                                SizedBox(height: TSizes.spaceBtwSections,),
                              ]
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections,),

                          //Variations
                          PV(),
                        ],
                      )),
                  SizedBox(width: TSizes.defaultSpace,),

                  //Side
                  Expanded(child: Column(
                    children: [
                      //Product Thumbnail
                      PTI(),
                      SizedBox(height: TSizes.spaceBtwSections,),

                      //Product Images
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('All Product Images',style: Theme.of(context).textTheme.headlineSmall,),
                            SizedBox(height: TSizes.spaceBtwItems,),
                            PAI(

                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwSections,),

                      //Product Brand
                      PB(),
                      SizedBox(height: TSizes.spaceBtwSections,),

                      //Product Categories
                      PC(),
                      SizedBox(height: TSizes.spaceBtwSections,),

                      //Product Visibility
                      PVW(),
                      SizedBox(height: TSizes.spaceBtwSections,),
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
