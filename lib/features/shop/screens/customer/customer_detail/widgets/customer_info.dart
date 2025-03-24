import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Information',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          //Personal Info Card
          Row(
            children: [
              TRoundedImage(
                padding: 0,
                backgroundColor: TColors.primaryBackground,
                image: customer.profilePicture.isNotEmpty
                    ? customer.profilePicture
                    : TImages.user,
                imageType: customer.profilePicture.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.fullName,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      customer.email,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          //Meta Data
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text('Username'),
              ),
              Text(':'),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(customer.username,
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
                  child: Text(customer.phoneNumber,
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Divider
          const Divider(),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Additional Details
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Order',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('7 Days Ago, #[35d435]')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Average Order Value',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('\$345'),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Additional Detail continue
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registered',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(customer.formattedDate)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Marketing',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('Subscribed'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
