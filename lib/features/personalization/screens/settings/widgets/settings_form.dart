import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
            
                //App name
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
            
                //tax shipping
                TDeviceUtils.isMobileScreen(context)? _buildMobile():_buildOther(),
            
            
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
            
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Update Profile')))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOther(){
    return Row(
      children: [
        //First Name
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'Tax %',
                label: Text('Tax Rate (&)'),
                prefixIcon: Icon(Iconsax.tag)),
          ),
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        //Last Name
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'Shipping Charge',
                label: Text('Shipping Charge (\$)'),
                prefixIcon: Icon(Iconsax.ship)),
          ),
        ),

        SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        //Last Name
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'Free Shipping After (\$)',
                label: Text('Free Shipping Threshold (\$)'),
                prefixIcon: Icon(Iconsax.ship)),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(){
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Tax %',
              label: Text('Tax Rate (&)'),
              prefixIcon: Icon(Iconsax.tag)),
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Last Name
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Shipping Charge',
              label: Text('Shipping Charge (\$)'),
              prefixIcon: Icon(Iconsax.ship)),
        ),

        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Last Name
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Free Shipping After (\$)',
              label: Text('Free Shipping Threshold (\$)'),
              prefixIcon: Icon(Iconsax.ship)),
        ),
      ],
    );
  }
}
