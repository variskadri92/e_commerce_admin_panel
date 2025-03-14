import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Orders',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Total Spent '),
                    TextSpan(text: '\$1234.65',style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary)),
                    TextSpan(text: ' on ${4} Orders'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems),
          TextFormField(
            onChanged: (query){},
            decoration: InputDecoration(
              hintText: 'Search Orders',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),

          SizedBox(height: TSizes.spaceBtwSections,),
          CustomerOrderTable(),
        ],
      ),
    );
  }
}
