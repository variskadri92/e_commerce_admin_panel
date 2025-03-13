import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

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
          MultiSelectDialogField(
              buttonText: Text('Select Categories'),
              title: Text('Categories'),
              items: [
                MultiSelectItem(
                    CategoryModel(name: 'Shoes', image: 'image', id: 'id'),
                    'Shoes'),
                MultiSelectItem(
                    CategoryModel(name: 'Shirts', image: 'image', id: 'id'),
                    'Shirts'),
              ],
              listType: MultiSelectListType.CHIP,
              onConfirm: (value) {})
        ],
      ),
    );
  }
}
