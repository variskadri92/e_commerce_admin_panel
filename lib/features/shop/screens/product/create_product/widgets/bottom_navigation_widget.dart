import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductBottomNavigationWidget extends StatelessWidget {
  const ProductBottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Discard button
          OutlinedButton(onPressed: () {}, child: Text('Discard')),
          SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),

          //Save button
          SizedBox(
              width: 160,
              child: ElevatedButton(
                  onPressed: () =>
                      CreateProductController.instance.createProduct(),
                  child: Text('Save Changes')))
        ],
      ),
    );
  }
}
