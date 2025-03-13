import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
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
          TypeAheadField(
              builder: (context, ctr, focusNode) {
                return TextFormField(
                  focusNode: focusNode,
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
              onSelected: (suggestion) {},
              suggestionsCallback: (pattern){

                //Return filtered list of brands based on pattern
                return [
                  BrandModel(name: 'Adidas', image: TImages.adidasLogo, id: 'id'),
                  BrandModel(name: 'Adidas', image: TImages.adidasLogo, id: 'id'),
                ];
              })
        ],
      ),
    );
  }
}
