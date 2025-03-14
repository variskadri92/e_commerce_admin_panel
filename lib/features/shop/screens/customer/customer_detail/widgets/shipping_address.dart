import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          //Address Card Meta Data
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text('Name'),
              ),
              Text(':'),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text('Yash Gotrijiya',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text('Country'),
              ),
              Text(':'),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text('India',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text('Phone Number'),
              ),
              Text(':'),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text('9999999999',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text('Address'),
              ),
              Text(':'),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text('404, apartment,city,state,country',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
