import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../../../models/category_model.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final productController = CreateProductController.instance;

    // Fetch all categories if list is empty
    if (categoryController.allItems.isEmpty) {
      categoryController.fetchItems();
    }

    if(productController.fetchedBrandCategories.isEmpty){
      productController.brandCategories();
    }

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: TSizes.spaceBtwItems),

          // Brand selection reminder or category selector
          Obx(() {
            if (productController.selectedBrand.value == null) {
              return Text(
                'Please select a brand first',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                ),
              );
            }

            if (categoryController.isLoading.value) {
              return TShimmerEffect(width: double.infinity, height: 50);
            }

            // Get brand-specific categories (if any filtering is needed)
            final brandCategoriesIds = productController.fetchedBrandCategories.where((brandCategory) => brandCategory.brandId == productController.selectedBrand.value!.id).map((brandCategory) => brandCategory.categoryId).toList(); // Modify if you need brand-specific filtering

            // Separate parents and subcategories
            final parentCategories = categoryController.allItems.where((cat) => cat.parentId.isEmpty && brandCategoriesIds.contains(cat.id)).toList();
            final subCategories = categoryController.allItems.where((cat) => cat.parentId.isNotEmpty && brandCategoriesIds.contains(cat.id)).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Parent Categories Section
                Text('Parent Categories', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                _buildCategoryChips(
                  parentCategories,
                  productController.selectedParentCategories,
                      (category) => productController.toggleParentCategory(category),
                ),

                // Subcategories Section (only for selected parents)
                if (productController.selectedParentCategories.isNotEmpty) ...[
                  SizedBox(height: TSizes.spaceBtwItems),
                  Text('Subcategories', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  _buildCategoryChips(
                    subCategories.where((sub) =>
                        productController.selectedParentCategories.any((parent) => parent.id == sub.parentId)
                    ).toList(),
                    productController.selectedCategories,
                        (category) => productController.toggleSubCategory(category),
                  ),
                ],

                // Selected Categories Summary
                if (productController.allSelectedCategories.isNotEmpty) ...[
                  SizedBox(height: TSizes.spaceBtwItems),
                  Text('Selected Categories', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  Wrap(
                    spacing: TSizes.sm,
                    children: productController.allSelectedCategories.map((category) {
                      final isParent = productController.selectedParentCategories.contains(category);
                      return Chip(
                        label: Text(category.name),
                        backgroundColor: isParent ? Colors.blue.withOpacity(0.2) : null,
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => isParent
                            ? productController.removeParentCategory(category)
                            : productController.removeSubCategory(category),
                      );
                    }).toList(),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(
      List<CategoryModel> categories,
      RxList<CategoryModel> selectedCategories,
      Function(CategoryModel) onTap,
      ) {
    return Wrap(
      spacing: TSizes.sm,
      children: categories.map((category) {
        final isSelected = selectedCategories.contains(category);
        return FilterChip(
          label: Text(category.name),
          selected: isSelected,
          onSelected: (selected) => onTap(category),
        );
      }).toList(),
    );
  }
}