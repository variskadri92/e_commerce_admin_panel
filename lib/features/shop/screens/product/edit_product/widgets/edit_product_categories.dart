import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/cloud_helper_functions.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/category/category_controller.dart';

class EditProductCategories extends StatelessWidget {
  const EditProductCategories({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
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
          FutureBuilder(future: EditProductController.instance.loadSelectedCategories(product.id), builder: (context, snapshot) {
            final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
            if(widget != null){
              return widget;
            }
            return MultiSelectDialogField(
                buttonText: Text('Select Categories'),
                title: Text('Categories'),
                initialValue: List<CategoryModel>.from(EditProductController.instance.selectedCategories),
                items: CategoryController.instance.allItems
                    .map((category) =>
                    MultiSelectItem(category, category.name))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  EditProductController.instance.selectedCategories.assignAll(values);
                });
          }),
        ],
      ),
    );
  }
}
