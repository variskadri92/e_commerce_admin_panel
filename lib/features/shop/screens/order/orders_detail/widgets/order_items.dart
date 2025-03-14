import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/pricing_calculator.dart';

import '../../../../../../utils/constants/enums.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          //Items
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                          backgroundColor: TColors.primaryBackground,
                          imageType: item.image != null
                              ? ImageType.network
                              : ImageType.asset,
                          image: item.image ?? TImages.defaultImage,
                        ),
                        SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (item.selectedVariation != null)
                                Text(
                                  item.selectedVariation!.entries
                                      .map((e) => ('${e.key} : ${e.value}'))
                                      .toString(),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  SizedBox(
                    width: TSizes.xl * 2,
                    child: Text(
                      '\$${item.price.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context)
                        ? TSizes.xl * 1.4
                        : TSizes.xl * 2,
                    child: Text(
                      item.quantity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context)
                        ? TSizes.xl * 1.4
                        : TSizes.xl * 2,
                    child: Text(
                      '\$${item.totalAmount}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: TSizes.spaceBtwSections),

          //Items Total
          TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            backgroundColor: TColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$$subTotal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$0.0',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${TPricingCalculator.calculateShippingCost(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Taxes',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${TPricingCalculator.calculateTax(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
