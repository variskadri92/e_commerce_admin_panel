import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../utils/validators/validation.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: TColors.primaryBackground,
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Form to add new attribute
        Form(
          child: TDeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAttributeName()),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildAttributeTextField(),
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    _buildAddAttributeButton(),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    _buildAttributeTextField(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    _buildAddAttributeButton(),
                  ],
                ),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        //List of added Attributes
        Text(
          'All Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Display added attributes in a rounded container
        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Column(
            children: [
              buildAttributesList(context),
              buildEmptyAttributes(),
            ],
          ),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        //Generate Variations Button
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              icon: Icon(Iconsax.activity),
              onPressed: () {},
              label: Text('Generate Variations'),
            ),
          ),
        )
      ],
    );
  }

  Column buildEmptyAttributes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: TImages.defaultAttributeColorsImageIcon,
            ),
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text('No attributes added yet'),
      ],
    );
  }

  ListView buildAttributesList(context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(
        height: TSizes.spaceBtwItems,
      ),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
          child: ListTile(
            title: Text('Color'),
            subtitle: Text('Red, Green, Blue'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Iconsax.trash,
                color: TColors.error,
              ),
            ),
          ),
        );
      },


    );
  }

  SizedBox _buildAddAttributeButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () {},
        label: Text('Add'),
        icon: Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: TColors.black,
          backgroundColor: TColors.secondary,
          side: BorderSide(color: TColors.secondary),
        ),
      ),
    );
  }

  TextFormField _buildAttributeName() {
    return TextFormField(
      validator: (value) =>
          TValidator.validateEmptyText('Attribute Name', value),
      decoration: InputDecoration(
          labelText: 'Attribute Name', hintText: 'Colors, Sizes, etc...'),
    );
  }

  SizedBox _buildAttributeTextField() {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            TValidator.validateEmptyText('Attribute Field', value),
        decoration: InputDecoration(
            labelText: 'Attributes',
            hintText: 'Add attributes separated by | Example: Green| Blue| Red',
            alignLabelWithHint: true),
      ),
    );
  }
}
