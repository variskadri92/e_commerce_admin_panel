import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/product_attributes_controller.dart';
import '../../../../controllers/product/product_variations_controller.dart';

class EditProductAttributes extends StatelessWidget {
  const EditProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;
    final attributeController = Get.put(ProductAttributesController());
    final variationController = Get.put(ProductVariationsController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Divider based on product type
        Obx(() {
          return productController.productType.value == ProductType.single
              ? Column(
            children: [
              Divider(
                color: TColors.primaryBackground,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          )
              : SizedBox.shrink();
        }),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Form to add new attribute
        Form(
          key: attributeController.attributesFormKey,
          child: TDeviceUtils.isDesktopScreen(context)
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAttributeName(attributeController)),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                flex: 2,
                child: _buildAttributeTextField(attributeController),
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              _buildAddAttributeButton(attributeController),
            ],
          )
              : Column(
            children: [
              _buildAttributeName(attributeController),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              _buildAttributeTextField(attributeController),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              _buildAddAttributeButton(attributeController),
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
          child: Obx(() => attributeController.productAttributes.isNotEmpty
              ? buildAttributesList(attributeController, context)
              : buildEmptyAttributes()),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        //Generate Variations Button
        Obx(
              ()=> productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty? Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                icon: Icon(Iconsax.activity),
                onPressed: ()=> variationController.generateVariationsConfirmation(context),
                label: Text('Generate Variations'),
              ),
            ),
          ): SizedBox.shrink(),
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

  ListView buildAttributesList(
      ProductAttributesController controller, context) {
    return ListView.separated(
      itemCount: controller.productAttributes.length,
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
            title: Text(controller.productAttributes[index].name ?? ''),
            subtitle: Text(controller.productAttributes[index].values!
                .map((e) => e.trim())
                .toString()),
            trailing: IconButton(
              onPressed: ()=> controller.removeAttribute(index, context),
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

  SizedBox _buildAddAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
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

  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          TValidator.validateEmptyText('Attribute Name', value),
      decoration: InputDecoration(
          labelText: 'Attribute Name', hintText: 'Colors, Sizes, etc...'),
    );
  }

  SizedBox _buildAttributeTextField(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller.attributes,
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
