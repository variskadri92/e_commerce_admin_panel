import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';

import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../../../controllers/category/edit_category_controller.dart';
import '../../../../models/category_model.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    final categoryController = Get.put(CategoryController());
    // Defer initialization until after the build process
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editController.initData(category);
    });
    //editController.initData(category);
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: editController.editFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading
              SizedBox(
                height: TSizes.sm,
              ),
              Text(
                'Update Category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Name Text Field
              TextFormField(
                controller: editController.name,
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

              Obx(
                    () => DropdownButtonFormField<CategoryModel?>(
                  decoration: InputDecoration(
                    hintText: 'Parent Category',
                    labelText: 'Parent Category',
                    prefixIcon: Icon(Iconsax.bezier),
                  ),
                  value: editController.selectedParent.value.id.isNotEmpty
                      ? editController.selectedParent.value
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
                    editController.selectedParent.value = newValue ?? CategoryModel.empty();
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
                  image: editController.imageURL.value.isNotEmpty
                      ? editController.imageURL.value
                      : TImages.defaultImage,
                  imageType: editController.imageURL.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  onIconButtonPressed: () => editController.pickImage(),
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              Obx(
                () => CheckboxMenuButton(
                    value: editController.isFeatured.value,
                    onChanged: (value) => editController.isFeatured.value = value ?? false,
                    child: Text('Featured')),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => editController.updateCategory(category),
                  child: Text('Update'),
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
