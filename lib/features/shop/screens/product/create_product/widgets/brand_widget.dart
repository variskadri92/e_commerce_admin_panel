import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/brand/brand_controller.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final createProductController = Get.put(CreateProductController());
    final brandController = Get.put(BrandController());

    //Fetch all brands if list is empty
    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Brand label
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //TypeAheadField for brand selection
          Obx(
            () => brandController.isLoading.value
                ? TShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(
                    builder: (context, ctr, focusNode) {
                      return TextFormField(
                        focusNode: focusNode,
                        controller: createProductController.brandTextField =
                            ctr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Brand',
                          suffixIcon: Icon(Iconsax.box),
                        ),
                      );
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                      );
                    },
                    onSelected: (suggestion) {
                      createProductController.updateSelectedBrand(suggestion);
                      createProductController.brandTextField.text =
                          suggestion.name;
                    },
                    suggestionsCallback: (pattern) {
                      //Return filtered list of brands based on pattern
                      return brandController.allItems
                          .where((brand) => brand.name.toLowerCase().contains(pattern.toLowerCase()))
                          .toList();
                    }),
          )
        ],
      ),
    );
  }
}
