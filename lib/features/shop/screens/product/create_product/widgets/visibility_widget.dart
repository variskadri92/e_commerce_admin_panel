import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Visibility Header
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //Radio buttons for product visibility
          Column(
            children: [
              _buildVisibilityRadioButton(
                  ProductVisibility.published, 'Published'),
              _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildVisibilityRadioButton(ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
        value: value,
        groupValue: ProductVisibility.published,
        onChanged: (selection) {},
        child: Text(label));
  }
}
