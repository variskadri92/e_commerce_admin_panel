import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/validators/validation.dart';

import '../../../../controllers/category/category_controller.dart';
import '../../../../controllers/category/create_category_controller.dart';
import '../../../../models/category_model.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: createController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading
              SizedBox(
                height: TSizes.sm,
              ),
              Text(
                'Create New Category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Name Text Field
              TextFormField(
                controller: createController.name,
                validator: (value) =>
                    TValidator.validateEmptyText('Name', value),
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Iconsax.category),
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              //Category Dropdown
              Obx(
                    () => categoryController.isLoading.value
                    ? TShimmerEffect(width: double.infinity, height: 55)
                    : DropdownButtonFormField<CategoryModel?>(
                  decoration: InputDecoration(
                    hintText: 'Parent Category',
                    labelText: 'Parent Category',
                    prefixIcon: Icon(Iconsax.bezier),
                  ),
                  value: createController.selectedParent.value.id.isNotEmpty
                      ? createController.selectedParent.value
                      : null, // Allow null value
                  items: [
                    // Add a null option for "No Parent Category"
                    DropdownMenuItem<CategoryModel?>(
                      value: null,
                      child: Text('No Parent Category'),
                    ),
                    // Add other categories
                    ...categoryController.allItems.map(
                          (item) => DropdownMenuItem<CategoryModel?>(
                        value: item,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [Text(item.name)],
                        ),
                      ),
                    ),
                  ],
                  onChanged: (newValue) {
                    // Handle null value
                    createController.selectedParent.value = newValue ?? CategoryModel.empty();
                  },
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                () => TImageUploader(
                  width: 80,
                  height: 80,
                  image: createController.imageURL.value.isNotEmpty
                      ? createController.imageURL.value
                      : TImages.defaultImage,
                  imageType: createController.imageURL.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  onIconButtonPressed: () => createController.pickImage(),
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              Obx(
                ()=> CheckboxMenuButton(
                  value: createController.isFeatured.value,
                  onChanged: (value) => createController.isFeatured.value = value ?? false,
                  child: Text('Featured'),
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=> createController.createCategory(),
                  child: Text('Create'),
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
