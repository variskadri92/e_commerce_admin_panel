import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/create_product_controller.dart';
import '../../../../models/product_model.dart';

class EditProductBottomNavigationWidget extends StatelessWidget {
  const EditProductBottomNavigationWidget({super.key, required this.product});

  final ProductModel product;

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
                      EditProductController.instance.updateProduct(product),
                  child: Text('Save Changes')))
        ],
      ),
    );
  }
}
