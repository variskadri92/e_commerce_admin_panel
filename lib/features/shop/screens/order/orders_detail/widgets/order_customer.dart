import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../utils/constants/sizes.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Personal Info
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Row(
                children: [
                  TRoundedImage(
                    padding: 0,
                    backgroundColor: TColors.primaryBackground,
                    image: TImages.user,
                    imageType: ImageType.asset,
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yash Gotrijiya',
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          'yashgotrijiya@gmail.com',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        //Contact Info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Person',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  'Yash Gotrijiya',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections/2,
                ),
                Text(
                  'ygo@gmail.com',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  '(+91) ***** *****',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),


        //Shipping Info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  'Yash Gotrijiya PVT LTD.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections/2,
                ),
                Text(
                  '044, apartment, road, city, state, country - 123456',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: TSizes.spaceBtwSections,),

        //Billing Info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  'Yash Gotrijiya PVT LTD.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections/2,
                ),
                Text(
                  '044, apartment, road, city, state, country - 123456',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),

      ],
    );
  }
}
