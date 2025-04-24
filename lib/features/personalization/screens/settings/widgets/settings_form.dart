import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/settings_controller.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Column(
      children: [
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Form(
            key: controller.settingFormKey,
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
                  controller: controller.appNameController,
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
                TDeviceUtils.isMobileScreen(context)
                    ? _buildMobile(controller)
                    : _buildOther(controller),

                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                SizedBox(
                    width: double.infinity,
                    child: Obx(
                      ()=> ElevatedButton(
                          onPressed: () => controller.loading.value
                              ? () {}
                              : controller.updateSettingInformation(),
                          child: controller.loading.value
                              ? CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2)
                              : Text('Update App Settings')),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOther(SettingsController controller) {
    return Row(
      children: [
        //First Name
        Expanded(
          child: TextFormField(
            controller: controller.taxController,
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
            controller: controller.shippingController,
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
            controller: controller.freeShippingLimitController,
            decoration: InputDecoration(
                hintText: 'Free Shipping After (\$)',
                label: Text('Free Shipping Threshold (\$)'),
                prefixIcon: Icon(Iconsax.ship)),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(SettingsController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller.taxController,
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
          controller: controller.shippingController,
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
          controller: controller.freeShippingLimitController,
          decoration: InputDecoration(
              hintText: 'Free Shipping After (\$)',
              label: Text('Free Shipping Threshold (\$)'),
              prefixIcon: Icon(Iconsax.ship)),
        ),
      ],
    );
  }
}
