import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/category/category_controller.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    //Fetch all categories if list is empty
    if (categoryController.allItems.isEmpty) {
      categoryController.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //MultiSelectDialogField for selecting categories
          Obx(
            () => categoryController.isLoading.value
                ? TShimmerEffect(width: double.infinity, height: 50)
                : MultiSelectDialogField(
                    buttonText: Text('Select Categories'),
                    title: Text('Categories'),
                    items: categoryController.allItems
                        .map((category) =>
                            MultiSelectItem(category, category.name))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      CreateProductController.instance.selectedCategories.assignAll(values);
                    }),
          )
        ],
      ),
    );
  }
}
