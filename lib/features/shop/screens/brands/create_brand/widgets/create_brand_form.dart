import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/brand/create_brand_controller.dart';
import '../../../../controllers/category/category_controller.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.createBrandFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            SizedBox(
              height: TSizes.sm,
            ),
            Text(
              'Create New Brand',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Name Text Field
            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),

            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // Parent Categories Section
            Text('Select Parent Categories', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: TSizes.spaceBtwInputFields / 2),

            // Search for parent categories
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Parent Categories',
              ),
              onChanged: (value) {
                controller.searchTextParent.value = value;
                controller.update();
              },
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            // Parent categories list
            Obx(
                  () => Wrap(
                spacing: TSizes.sm,
                children: controller.parentCategories
                    .map((category) => Padding(
                  padding: EdgeInsets.only(bottom: TSizes.sm),
                  child: TChoiceChip(
                    text: category.name,
                    selected: controller.selectedParentCategories.contains(category),
                    onSelected: (value) => controller.toggleParentSelection(category),
                  ),
                ))
                    .toList(),
              ),
            ),

            // Subcategories Section (only shows if parents are selected)
            Obx(() => controller.selectedParentCategories.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: TSizes.spaceBtwInputFields),
                Text('Select Subcategories', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: TSizes.spaceBtwInputFields / 2),

                // Search for subcategories
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Subcategories',
                  ),
                  onChanged: (value) {
                    controller.searchTextSub.value = value;
                    controller.updateAvailableSubCategories();
                  },
                ),
                SizedBox(height: TSizes.spaceBtwInputFields),

                // Subcategories list
                Obx(
                      () => Wrap(
                    spacing: TSizes.sm,
                    children: controller.availableSubCategories
                        .map((category) => Padding(
                      padding: EdgeInsets.only(bottom: TSizes.sm),
                      child: TChoiceChip(
                        text: category.name,
                        selected: controller.selectedCategories.contains(category),
                        onSelected: (value) => controller.toggleSubCategorySelection(category),
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ],
            )
                : SizedBox.shrink()),
            SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),

            Obx(
                  () => TImageUploader(
                width: 80,
                height: 80,
                image: controller.imageURL.value.isNotEmpty
                    ? controller.imageURL.value
                    : TImages.defaultImage,
                imageType: controller.imageURL.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => controller.pickImage(),
              ),
            ),

            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            Obx(
                  ()=> CheckboxMenuButton(
                value: controller.isFeatured.value,
                onChanged: (value) => controller.isFeatured.value = value ?? false,
                child: Text('Featured'),
              ),
            ),

            SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=> controller.createBrand(),
                child: Text('Create'),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
          ],
        ),
      ),
    );
  }
}
